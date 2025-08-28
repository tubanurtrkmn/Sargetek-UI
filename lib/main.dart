
import 'package:flutter/material.dart';
import 'screens/birads_screen.dart';
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
        '/birads': (context) => const BiradsScreen(),
        '/bkategori': (context) => const BKategoriScreen(),
        '/uyum': (context) => const UyumScreen(),
        '/tani': (context) => const TaniScreen(),
      },
    );
  }
}
