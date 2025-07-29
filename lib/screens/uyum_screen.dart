import 'package:flutter/material.dart';
import 'tab_bar_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UyumScreen extends StatefulWidget {
  final bool showTabBar;
  const UyumScreen({super.key, this.showTabBar = true});

  @override
  State<UyumScreen> createState() => _UyumScreenState();
}

class _UyumScreenState extends State<UyumScreen> {
  final TextEditingController biradsController = TextEditingController();
  final TextEditingController patolojiController = TextEditingController();
  bool showWarning = false;
  bool showResult = false;

  bool get canAnalyze => biradsController.text.trim().isNotEmpty && patolojiController.text.trim().isNotEmpty;

  void analyze() async {
    if (!canAnalyze) {
      setState(() {
        showWarning = true;
      });
      return;
    }
    setState(() {
      showWarning = false;
      showResult = true;
    });

    try {
      final result = await predictUyum(biradsController.text, patolojiController.text);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Uyum Sonucu'),
          content: Text(
            result != null
                ? 'Uyumsuz:  \t${result['uyumsuz'] == 1 ? 'Evet' : 'Hayır'}\nGüven: ${result['confidence']}'
                : 'Tahmin alınamadı!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  showResult = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('Tahmin alınamadı: $e'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  showResult = false;
                });
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showTabBar) const AnalysisTabBar(activeRoute: '/uyum'),
                if (widget.showTabBar) const SizedBox(height: 32),
                const Text(
                  'RADYOLOJİ VE PATOLOJİ KATEGORİLERİNİ GİRİN',
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
                        'BI-RADS Kategorisi',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: biradsController,
                        maxLines: 2,
                        readOnly: false,
                        showCursor: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          hintText: 'Örn: 4a',
                          filled: true,
                          fillColor: const Color(0xFFF4FAFF),
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFB0B4BA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFB0B4BA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFB0B4BA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onTap: () {},
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Patoloji Raporu',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: patolojiController,
                        maxLines: 5,
                        readOnly: false,
                        showCursor: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          hintText: 'Patoloji raporunu giriniz.',
                          filled: true,
                          fillColor: const Color(0xFFF4FAFF),
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFB0B4BA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFB0B4BA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFB0B4BA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onTap: () {},
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (showWarning)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Lütfen iki alanı da doldurun.', style: TextStyle(color: Colors.red, fontSize: 16)),
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
                        child: const Text('Sonuçları Analiz Et', style: TextStyle(fontSize: 20, color: Colors.white)),
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

Future<Map<String, dynamic>?> predictUyum(String birads, String patoloji) async {
  final url = Uri.parse('http://127.0.0.1:8000/predictUyum'); // Gerekirse değiştir
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'birads_kategori': birads,
      'patoloji_kategori': patoloji,
    }),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}
