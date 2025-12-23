# YouTube AI Scraping Agent

This project is a technical assessment developed for AIMultiple. The agent automates the process of discovering an artist's first album and analyzing the lyrics of all songs in that album using AI models and web scraping tools.

## Features
- **Artist Discovery:** Extracts the artist name from a provided YouTube URL using Apify's YouTube Scraper.
- **Album Identification:** Uses an LLM (OpenRouter) to identify the artist's first studio album and its tracklist in chronological order.
- **Lyrics Scraping:** For each song, the agent searches for Genius.com links and scrapes raw lyrics using Apify's Google Search and Web Scraper actors.
- **Metrics Analysis:** Computes character count, word count, and token count (via `tiktoken`).
- **Cryptographic Hashing:** Generates MD5 hashes for individual song lyrics and a final hash for the entire album based on Nomic embeddings of token counts.

## Technical Stack
    ## Technical Notes & Validation
    - **Model Selection:** During development and local testing, `google/gemini-2.0-flash-exp:free` was utilized to manage API quotas and ensure stability. For the final submission, the model has been updated to `openai/gpt-5.2` as per the assessment requirements.
    - **Output Validation:** The system was successfully validated using the provided Madonna example. All metrics (character count, token count via cl100k_base, and MD5 hashing) were cross-referenced with expected outputs.
    - **Rate Limiting:** To avoid upstream rate limits during scraping, sequential execution was preferred over parallel processing.

- **Language:** Python 3.12+
- **APIs:** Apify, OpenRouter (LLM)
- **AI Models:** - LLM: `openai/gpt-5.2` (via OpenRouter)
  - Embedding: `nomic-ai/nomic-embed-text-v1.5`
- **Tokenization:** `cl100k_base` (tiktoken)

## Setup and Installation
1. Clone the repository or download the files.
2. Create a virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
3. Install the required dependencies:

Bash
pip install -r requirements.txt
4. Create a .env file in the root directory and add your API keys:

Plaintext
APIFY_API_KEY=your_apify_key
OPENROUTER_API_KEY=your_openrouter_key

USAGE 
The system supports two output modes: json and hash.

1. JSON Output

To get the full analysis of the album in JSON format:

Bash
python3 Tubanur_Turkmen_YouTube_AI.py "[https://www.youtube.com/watch?v=rSaC-YbSDpo](https://www.youtube.com/watch?v=rSaC-YbSDpo)" json
2. Hash Output

To compute the final standardized MD5 hash of the album's embedding:

Bash
python3 Tubanur_Turkmen_YouTube_AI.py "[https://www.youtube.com/watch?v=rSaC-YbSDpo](https://www.youtube.com/watch?v=rSaC-YbSDpo)" hash
Error Handling
The agent includes error management for API connectivity, credit limits, and scraping failures. Log messages are displayed in the terminal to track the agent's real-time progress.

Author
Tubanur Turkmen