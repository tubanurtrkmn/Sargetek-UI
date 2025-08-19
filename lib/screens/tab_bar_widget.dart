import 'package:flutter/material.dart';

class AnalysisTabBar extends StatelessWidget {
  final String activeRoute;
  final bool isLocal;
  final void Function(String route)? onTabSelected;
  const AnalysisTabBar({Key? key, required this.activeRoute, this.isLocal = false, this.onTabSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_TabData> tabs = [
      // _TabData('BI-RADS Analizi', '/birads'), // YORUM SATIRI - BI-RADS sekmesi geçici olarak kaldırıldı
      _TabData('Patoloji B Kategori Tahmini', '/bkategori'),
      _TabData('Bırads-B Kategori Karşılaştırması', '/uyum'),
      _TabData('Uyumluluk Analizi', '/tani'),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: tabs.map((tab) {
        final bool selected = tab.route == activeRoute;
        return _TabNav(
          title: tab.title,
          selected: selected,
          onTap: selected
              ? null
              : () {
                  if (isLocal && onTabSelected != null) {
                    onTabSelected!(tab.route);
                  } else {
                    Navigator.pushReplacementNamed(context, tab.route);
                  }
                },
        );
      }).toList(),
    );
  }
}

class _TabData {
  final String title;
  final String route;
  _TabData(this.title, this.route);
}

class _TabNav extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback? onTap;
  const _TabNav({required this.title, required this.selected, required this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF47BA3) : const Color(0xFFF8AFCB),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: selected
              ? [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]
              : [],
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
} 