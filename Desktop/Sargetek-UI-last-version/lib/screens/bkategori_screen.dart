import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tab_bar_widget.dart';

class BKategoriScreen extends StatefulWidget {
  final bool showTabBar;
  const BKategoriScreen({super.key, this.showTabBar = true});

  @override
  State<BKategoriScreen> createState() => _BKategoriScreenState();
}

class _BKategoriScreenState extends State<BKategoriScreen> {
  String? fileName;
  final TextEditingController textController = TextEditingController();
  bool showWarning = false;
  bool showResult = false;
  bool isLoading = false;

  void onTextChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        fileName = null;
        showWarning = false;
      });
    }
  }

  bool get canAnalyze => textController.text.trim().isNotEmpty && !isLoading;

  void analyze() async {
    if (!canAnalyze) {
      setState(() {
        showWarning = true;
      });
      return;
    }

    setState(() {
      showWarning = false;
      isLoading = true;
    });

    try {
      final result = await predictPatolojiB(textController.text);
      setState(() {
        showResult = true;
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sonuç'),
          content: Text(
              'Patoloji B Kategori: ${result['pathCategory']}\nGüven: ${result['confidence']}'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  showResult = false;
                  textController.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('Tahmin alınamadı: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final Color bgColor = const Color(0xE6EAF3FA);
    final Color buttonColor = const Color(0xFF233D85);

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            height: 580,
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showTabBar)
                  const AnalysisTabBar(activeRoute: '/bkategori'),
                if (widget.showTabBar) const SizedBox(height: 24),
                const Text(
                  'PATOLOJİ RAPORUNU GİRİNİZ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF2C3848),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Patoloji Raporu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF2C3848)),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: textController,
                        maxLines: 7,
                        onChanged: onTextChanged,
                        decoration: const InputDecoration(
                          hintText: 'Patoloji raporunu giriniz.',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFB0B4BA)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (showWarning)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Lütfen metin girin.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 102, 21, 122),
                        fontSize: 16,
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 320,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: canAnalyze ? analyze : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sonuçları Analiz Et',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> predictPatolojiB(String sonucPatoloji) async {
  final url = Uri.parse('http://127.0.0.1:8000/predictPatolojiB');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'sonuc_patoloji': sonucPatoloji}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Tahmin alınamadı: ${response.body}');
  }
}
