import os
import sys
import json
import hashlib
import tiktoken
from dotenv import load_dotenv
from apify_client import ApifyClient
from openai import OpenAI
from sentence_transformers import SentenceTransformer
load_dotenv()

class YoutubeAIAgent:
    def __init__(self):
        # Initialize API clients
        self.apify_client = ApifyClient(os.getenv("APIFY_API_KEY"))
        self.ai_client = OpenAI(
            base_url="https://openrouter.ai/api/v1",
            api_key=os.getenv("OPENROUTER_API_KEY")
        )
        # Initialize metrics and embedding models
        self.tokenizer = tiktoken.get_encoding("cl100k_base")
        self.embed_model = SentenceTransformer('nomic-ai/nomic-embed-text-v1.5', trust_remote_code=True)

    def get_artist(self, url):
        """Step 1: Get singer's name using Apify Youtube Scraper."""
        run_input = {"startUrls": [{"url": url}], "maxResults": 1}
        try:
            run = self.apify_client.actor("streamers/youtube-scraper").call(run_input=run_input)
            for item in self.apify_client.dataset(run["defaultDatasetId"]).iterate_items():
                return item.get("channelName") or item.get("author")
        except Exception as e:
            print(f"Error fetching artist: {e}")
        return None

    def get_album_info(self, artist):
        """Step 2: Get first album's songs via LLM."""
        model_name = "openai/gpt-5.2" 
        prompt = f"Find the first studio album of {artist}. List all songs in original release order. Return ONLY a JSON object: {{\"album_name\": \"...\", \"songs\": [\"song1\", \"song2\"]}}"
        try:
            response = self.ai_client.chat.completions.create(
                model=model_name,
                messages=[{"role": "user", "content": prompt}],
                response_format={"type": "json_object"}
            )
            return json.loads(response.choices[0].message.content)
        except Exception as e:
            print(f"Error fetching album info: {e}")
            return None

    def get_lyrics(self, song, artist):
        """Step 3-4: Scrape lyrics from genius.com using Apify actors."""
        search_query = f"{song} {artist} Genius lyrics"
        try:
     
            search_run = self.apify_client.actor("apify/google-search-scraper").call(run_input={"queries": search_query, "maxPagesPerQuery": 1})
            genius_url = None
            for item in self.apify_client.dataset(search_run["defaultDatasetId"]).iterate_items():
                for result in item.get("organicResults", []):
                    if "genius.com" in result["url"]:
                        genius_url = result["url"]
                        break
            
            if not genius_url: return ""
            
      
            web_run = self.apify_client.actor("apify/web-scraper").call(run_input={
                "startUrls": [{"url": genius_url}],
            })
            for item in self.apify_client.dataset(web_run["defaultDatasetId"]).iterate_items():
                return item.get("text", "")
        except Exception as e:
            print(f"Error scraping lyrics for {song}: {e}")
        return ""

    def process(self, url, mode):
        try:
            artist = self.get_artist(url)
            if not artist: return

            album_data = self.get_album_info(artist)
            if not album_data: return

            songs_results = []
            token_counts = []
            
            for song_name in album_data["songs"]:
                lyrics = self.get_lyrics(song_name, artist)
                if not lyrics: continue
                
                # Step 5: Calculate token metrics
                tokens = self.tokenizer.encode(lyrics)
                char_count = len(lyrics)
                word_count = len(lyrics.split())
                token_count = len(tokens)
                tpw = round(token_count / word_count, 2) if word_count > 0 else 0
                l_hash = hashlib.md5(lyrics.encode('utf-8')).hexdigest()
                
                songs_results.append({
                    "name": song_name,
                    "lyrics_length_chars": char_count,
                    "lyrics_length_words": word_count,
                    "lyrics_length_tokens": token_count,
                    "tokens_per_word": tpw,
                    "lyrics_hash": l_hash
                })
                token_counts.append(token_count)

            if mode == "json":
                # Step 5 Final JSON
                total_tokens = sum(token_counts)
                final_json = {
                    "artist": artist,
                    "album_name": album_data["album_name"],
                    "songs": songs_results,
                    "total_tokens_all_songs": total_tokens,
                    "avg_tokens_per_song": round(total_tokens / len(songs_results), 2) if songs_results else 0
                }
                print(json.dumps(final_json, indent=2))
            
            elif mode == "hash":
                # Step 6, 7 & 8: Embedding and Final MD5
                concat_str = ",".join(map(str, token_counts))
                embedding = self.embed_model.encode(concat_str)
                # Standardize float vector to 10 decimal points (Step 7.3)
                formatted_vector = ",".join([f"{num:.10f}" for num in embedding])
                print(hashlib.md5(formatted_vector.encode('utf-8')).hexdigest())

        except Exception as e:
            print(f"Workflow error: {e}")

if __name__ == "__main__":
    if len(sys.argv) == 3:
        url_input = sys.argv[1]
        mode_input = sys.argv[2]
        agent = YoutubeAIAgent()
        agent.process(url_input, mode_input)