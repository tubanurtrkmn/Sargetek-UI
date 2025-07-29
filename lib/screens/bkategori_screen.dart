import 'package:flutter/material.dart';
import 'dart:html' as html;
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

  void uploadFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf,.png,.jpg,.jpeg';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        setState(() {
          fileName = file.name;
          textController.clear();
        });
      }
    });
  }

  void onTextChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        fileName = null;
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
                if (widget.showTabBar) const AnalysisTabBar(activeRoute: '/bkategori'),
                if (widget.showTabBar) const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PATOLOJİ RAPORUNU YÜKLE YA DA OLUŞTUR',
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
                                onTap: fileName == null && textController.text.trim().isEmpty ? uploadFile : null,
                                borderRadius: BorderRadius.circular(4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.upload_file, size: 48, color: Color(0xFF2C3848)),
                                    const SizedBox(height: 12),
                                    fileName == null
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text('Patoloji raporunu yükle', style: TextStyle(fontSize: 18, color: Color(0xFF2C3848))),
                                              SizedBox(height: 4),
                                              Text('(.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFFB0B4BA))),
                                            ],
                                          )
                                        : Text('Yüklendi: $fileName', style: const TextStyle(fontSize: 16, color: Colors.green)),
                                    if (fileName != null)
                                      TextButton(
                                        onPressed: () => setState(() => fileName = null),
                                        child: const Text(
                                          'Dosyayı kaldır',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                        ),
                                      ),
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
                                    'Patoloji Raporu',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: textController,
                                    enabled: true,
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
                              onTap: fileName == null && textController.text.trim().isEmpty ? uploadFile : null,
                              borderRadius: BorderRadius.circular(4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.upload_file, size: 48, color: Color(0xFF2C3848)),
                                  const SizedBox(height: 12),
                                  fileName == null
                                      ? const Text('Patoloji raporunu yükle \n (.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 18, color: Color(0xFF2C3848)))
                                      : Text('Yüklendi: $fileName', style: const TextStyle(fontSize: 16, color: Colors.green)),
                                  if (fileName != null)
                                    TextButton(
                                      onPressed: () => setState(() => fileName = null),
                                      child: const Text(
                                        'Dosyayı kaldır',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                    ),
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
                                  'Patoloji Formu',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: textController,
                                  enabled: true,
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
                    child: Text('Lütfen dosya yükleyin veya metin girin.', style: TextStyle(color: Colors.red, fontSize: 16)),
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
