import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'tab_bar_widget.dart';

class BiradsScreen extends StatefulWidget {
  final bool showTabBar;
  const BiradsScreen({super.key, this.showTabBar = true});

  @override
  State<BiradsScreen> createState() => _BiradsScreenState();
}

class _BiradsScreenState extends State<BiradsScreen> {
  final TextEditingController textController = TextEditingController();
  bool showWarning = false;
  bool showResult = false;

  void onTextChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        // fileName = null; // Removed as per edit hint
      });
    }
    setState(() {});
  }

  bool get canAnalyze => textController.text.trim().isNotEmpty;

  void analyze() {
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
              setState(() { showResult = false; });
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
    final Color borderColor = Colors.black;
    final Color buttonColor = const Color(0xFF233D85);
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showTabBar)
                  const AnalysisTabBar(activeRoute: '/birads'),
                if (widget.showTabBar) const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'RADYOLOJİ RAPORUNU YÜKLE YA DA OLUŞTUR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF2C3848),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sol: Dosya yükleme kutusu
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 340,
                              decoration: BoxDecoration(
                                border: Border.all(color: borderColor, width: 2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: InkWell(
                                onTap: null, // Removed as per edit hint
                                borderRadius: BorderRadius.circular(4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.upload_file, size: 48, color: Color(0xFF2C3848)),
                                    const SizedBox(height: 12),
                                    // fileName == null // Removed as per edit hint
                                    //     ? Column( // Removed as per edit hint
                                    //         children: [ // Removed as per edit hint
                                    //           const Text('Radyoloji raporunu yükle', style: TextStyle(fontSize: 18, color: Color(0xFF2C3848))), // Removed as per edit hint
                                    //           SizedBox(height: 4), // Removed as per edit hint
                                    //           Text('(.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFFB0B4BA))), // Removed as per edit hint
                                    //         ], // Removed as per edit hint
                                    //       ) // Removed as per edit hint
                                    //     : Text('Yüklendi: $fileName', style: const TextStyle(fontSize: 16, color: Colors.green)), // Removed as per edit hint
                                    // if (fileName != null) // Removed as per edit hint
                                    //   TextButton( // Removed as per edit hint
                                    //     onPressed: () => setState(() => fileName = null), // Removed as per edit hint
                                    //     child: const Text( // Removed as per edit hint
                                    //       'Dosyayı kaldır', // Removed as per edit hint
                                    //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15), // Removed as per edit hint
                                    //     ), // Removed as per edit hint
                                    //   ), // Removed as per edit hint
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Sağ: Açıklama kutusu
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 340,
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
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: textController,
                                    enabled: true, // Changed as per edit hint
                                    maxLines: 8,
                                    onChanged: onTextChanged,
                                    decoration: const InputDecoration(
                                      hintText: 'Açıklayınız.',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: 340,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: null, // Removed as per edit hint
                              borderRadius: BorderRadius.circular(4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.upload_file, size: 48, color: Color(0xFF2C3848)),
                                  const SizedBox(height: 12),
                                  // fileName == null // Removed as per edit hint
                                  //     ? Column( // Removed as per edit hint
                                  //         children: [ // Removed as per edit hint
                                  //           const Text('Radyoloji raporunu yükle', style: TextStyle(fontSize: 18, color: Color(0xFF2C3848))), // Removed as per edit hint
                                  //           SizedBox(height: 4), // Removed as per edit hint
                                  //           Text('(.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFFB0B4BA))), // Removed as per edit hint
                                  //         ], // Removed as per edit hint
                                  //       ) // Removed as per edit hint
                                  //     : Text('Yüklendi: $fileName', style: const TextStyle(fontSize: 16, color: Colors.green)), // Removed as per edit hint
                                  // if (fileName != null) // Removed as per edit hint
                                  //   TextButton( // Removed as per edit hint
                                  //     onPressed: () => setState(() => fileName = null), // Removed as per edit hint
                                  //     child: const Text( // Removed as per edit hint
                                  //       'Dosyayı kaldır', // Removed as per edit hint
                                  //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15), // Removed as per edit hint
                                  //     ), // Removed as per edit hint
                                  //   ), // Removed as per edit hint
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Radyoloji Formu',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: textController,
                                  enabled: true, // Changed as per edit hint
                                  maxLines: 8,
                                  onChanged: onTextChanged,
                                  decoration: const InputDecoration(
                                    hintText: 'Açıklayınız.',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 32),
                if (showWarning)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text('Lütfen metin girin (dosya yükleme kaldırıldı).', style: TextStyle(color: Colors.red, fontSize: 16)), // Updated message as per edit hint
                  ),
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
          ),
        ),
      ),
    );
  }
}
