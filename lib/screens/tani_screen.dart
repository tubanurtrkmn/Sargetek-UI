import 'package:flutter/material.dart';
import 'dart:html' as html;
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

  void uploadFileRad() {
    if (textRad.text.trim().isNotEmpty) return;
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf,.png,.jpg,.jpeg';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        setState(() {
          fileNameRad = file.name;
          textRad.clear();
        });
      }
    });
  }

  void uploadFilePat() {
    if (textPat.text.trim().isNotEmpty) return;
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf,.png,.jpg,.jpeg';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        setState(() {
          fileNamePat = file.name;
          textPat.clear();
        });
      }
    });
  }

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
    final radOk = (fileNameRad != null && fileNameRad!.isNotEmpty && textRad.text.trim().isEmpty) || (fileNameRad == null && textRad.text.trim().isNotEmpty);
    final patOk = (fileNamePat != null && fileNamePat!.isNotEmpty && textPat.text.trim().isEmpty) || (fileNamePat == null && textPat.text.trim().isNotEmpty);
    return radOk && patOk;
  }

  void analyze() {
    final radEmpty = (fileNameRad == null || fileNameRad!.isEmpty) && textRad.text.trim().isEmpty;
    final patEmpty = (fileNamePat == null || fileNamePat!.isEmpty) && textPat.text.trim().isEmpty;
    if (radEmpty || patEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Uyarı'),
          content: const Text('Metin yazınız ya da dosya yükleyiniz.'),
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
                if (widget.showTabBar) const AnalysisTabBar(activeRoute: '/tani'),
                if (widget.showTabBar) const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'RADYOLOJİ VE PATOLOJİ RAPORUNU YÜKLE YA DA OLUŞTUR',
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
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  constraints: const BoxConstraints(minWidth: 320, maxWidth: 500),
                                  height: 140,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: borderColor, width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: InkWell(
                                    onTap: fileNameRad == null && textRad.text.trim().isEmpty ? uploadFileRad : null,
                                    borderRadius: BorderRadius.circular(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.upload_file, size: 40, color: Color(0xFF2C3848)),
                                        const SizedBox(height: 8),
                                        fileNameRad == null
                                            ? const Text('Radyoloji raporunu yükle (.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFF2C3848)))
                                            : Text('Yüklendi: $fileNameRad', style: const TextStyle(fontSize: 13, color: Colors.green)),
                                        if (fileNameRad != null)
                                          TextButton(
                                            onPressed: () => setState(() => fileNameRad = null),
                                            child: const Text('Dosyayı kaldır'),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  constraints: const BoxConstraints(minWidth: 320, maxWidth: 500),
                                  height: 140,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: borderColor, width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: InkWell(
                                    onTap: fileNamePat == null && textPat.text.trim().isEmpty ? uploadFilePat : null,
                                    borderRadius: BorderRadius.circular(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.upload_file, size: 40, color: Color(0xFF2C3848)),
                                        const SizedBox(height: 8),
                                        fileNamePat == null
                                            ? const Text('Patoloji raporunu yükle (.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFF2C3848)))
                                            : Text('Yüklendi: $fileNamePat', style: const TextStyle(fontSize: 13, color: Colors.green)),
                                        if (fileNamePat != null)
                                          TextButton(
                                            onPressed: () => setState(() => fileNamePat = null),
                                            child: const Text('Dosyayı kaldır'),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
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
                                    controller: textRad,
                                    enabled: fileNameRad == null,
                                    maxLines: 3,
                                    onChanged: onTextChangedRad,
                                    decoration: const InputDecoration(
                                      hintText: 'Açıklayınız.',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'Patoloji Raporu',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: textPat,
                                    enabled: fileNamePat == null,
                                    maxLines: 3,
                                    onChanged: onTextChangedPat,
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
                            constraints: const BoxConstraints(minWidth: 320, maxWidth: 500),
                            height: 140,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: fileNameRad == null && textRad.text.trim().isEmpty ? uploadFileRad : null,
                              borderRadius: BorderRadius.circular(4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.upload_file, size: 40, color: Color(0xFF2C3848)),
                                  const SizedBox(height: 8),
                                  fileNameRad == null
                                      ? const Text('Radyoloji raporunu yükle (.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFF2C3848)))
                                      : Text('Yüklendi: $fileNameRad', style: const TextStyle(fontSize: 13, color: Colors.green)),
                                  if (fileNameRad != null)
                                    TextButton(
                                      onPressed: () => setState(() => fileNameRad = null),
                                      child: const Text('Dosyayı kaldır'),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(minWidth: 320, maxWidth: 500),
                            height: 140,
                            margin: const EdgeInsets.only(bottom: 16, top: 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: fileNamePat == null && textPat.text.trim().isEmpty ? uploadFilePat : null,
                              borderRadius: BorderRadius.circular(4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.upload_file, size: 40, color: Color(0xFF2C3848)),
                                  const SizedBox(height: 8),
                                  fileNamePat == null
                                      ? const Text('Patoloji raporunu yükle (.pdf, .png, .jpg, .jpeg)', style: TextStyle(fontSize: 15, color: Color(0xFF2C3848)))
                                      : Text('Yüklendi: $fileNamePat', style: const TextStyle(fontSize: 13, color: Colors.green)),
                                  if (fileNamePat != null)
                                    TextButton(
                                      onPressed: () => setState(() => fileNamePat = null),
                                      child: const Text('Dosyayı kaldır'),
                                    ),
                                ],
                              ),
                            ),
                          ),
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
                                  'Radyoloji Lexicon Uygun Tanımı',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: textRad,
                                  enabled: fileNameRad == null,
                                  maxLines: 3,
                                  onChanged: onTextChangedRad,
                                  decoration: const InputDecoration(
                                    hintText: 'Açıklayınız.',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Patoloji Raporu',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2C3848)),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: textPat,
                                  enabled: fileNamePat == null,
                                  maxLines: 3,
                                  onChanged: onTextChangedPat,
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
                    child: Text('Her iki alan için de dosya yükleyin veya metin girin (ikisi birden olamaz).', style: TextStyle(color: Colors.red, fontSize: 16)),
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