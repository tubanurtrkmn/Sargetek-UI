import 'package:flutter/material.dart';
// import 'dart:html' as html;
import 'tab_bar_widget.dart';

class TaniScreen extends StatefulWidget {
  final bool showTabBar;
  const TaniScreen({super.key, this.showTabBar = true});

  @override
  State<TaniScreen> createState() => _TaniScreenState();
}

class _TaniScreenState extends State<TaniScreen> {
  String? fileNameRad;
  String? fileNamePat;
  final TextEditingController textRad = TextEditingController();
  final TextEditingController textPat = TextEditingController();
  bool showWarning = false;
  bool showResult = false;

  void onTextChangedRad(String value) {
    if (value.isNotEmpty) {
      setState(() {
        fileNameRad = null;
      });
    }
    setState(() {});
  }

  void onTextChangedPat(String value) {
    if (value.isNotEmpty) {
      setState(() {
        fileNamePat = null;
      });
    }
    setState(() {});
  }

  bool get canAnalyze {
    final radOk = textRad.text.trim().isNotEmpty;
    final patOk = textPat.text.trim().isNotEmpty;
    return radOk && patOk;
  }

  void analyze() {
    final radEmpty = textRad.text.trim().isEmpty;
    final patEmpty = textPat.text.trim().isEmpty;
    if (radEmpty || patEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Uyarı'),
          content: const Text('Metin yazınız.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
      return;
    }
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sonuç'),
        content: const Text('Sonuç: deneme'),
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
              children: [
                if (widget.showTabBar) const AnalysisTabBar(activeRoute: '/tani'),
                if (widget.showTabBar) const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'RADYOLOJİ VE PATOLOJİ RAPORUNU OLUŞTUR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF2C3848),
                    ),
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
                        'Radyoloji Lexicon Uygun Tanımı',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: textRad,
                        maxLines: 3,
                        readOnly: false,
                        showCursor: true,
                        enableInteractiveSelection: true,
                        onChanged: onTextChangedRad,
                        decoration: InputDecoration(
                          hintText: 'Açıklayınız.',
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
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Patoloji Raporu',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: textPat,
                        maxLines: 3,
                        readOnly: false,
                        showCursor: true,
                        enableInteractiveSelection: true,
                        onChanged: onTextChangedPat,
                        decoration: InputDecoration(
                          hintText: 'Açıklayınız.',
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (showWarning)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text('Her iki alan için de metin girin.', style: TextStyle(color: Colors.red, fontSize: 16)),
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
