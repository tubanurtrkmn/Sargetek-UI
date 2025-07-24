import 'package:flutter/material.dart';
import 'tab_bar_widget.dart';
import 'birads_screen.dart';
import 'bkategori_screen.dart';
import 'uyum_screen.dart';
import 'tani_screen.dart';

class AnalizTabsScreen extends StatefulWidget {
  const AnalizTabsScreen({Key? key}) : super(key: key);

  @override
  State<AnalizTabsScreen> createState() => _AnalizTabsScreenState();
}

class _AnalizTabsScreenState extends State<AnalizTabsScreen> {
  int activeTab = 0;
  final List<String> routes = ['/birads', '/bkategori', '/uyum', '/tani'];

  Widget get activeContent {
    switch (activeTab) {
      case 0:
        return const BiradsScreen(showTabBar: false);
      case 1:
        return const BKategoriScreen(showTabBar: false);
      case 2:
        return const UyumScreen(showTabBar: false);
      case 3:
        return const TaniScreen(showTabBar: false);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xE6EAF3FA),
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
                AnalysisTabBar(
                  activeRoute: routes[activeTab],
                  onTabSelected: (route) {
                    setState(() {
                      activeTab = routes.indexOf(route);
                    });
                  },
                  isLocal: true,
                ),
                const SizedBox(height: 32),
                activeContent,
              ],
            ),
          ),
        ),
      ),
    );
  }
} 