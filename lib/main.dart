
import 'package:flutter/material.dart';
// import 'screens/birads_screen.dart'; // YORUM SATIRI - BI-RADS import'u geçici olarak kaldırıldı
import 'screens/bkategori_screen.dart';
import 'screens/uyum_screen.dart';
import 'screens/tani_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SargetekApp());
}

class SargetekApp extends StatelessWidget {
  const SargetekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sargetek Meme Kanseri Tespit',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFEAF3FA),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/birads': (context) => const BiradsScreen(), // YORUM SATIRI - BI-RADS route'u geçici olarak kaldırıldı
        '/bkategori': (context) => const BKategoriScreen(),
        '/uyum': (context) => const UyumScreen(),
        '/tani': (context) => const TaniScreen(),
      },
    );
  }
}
