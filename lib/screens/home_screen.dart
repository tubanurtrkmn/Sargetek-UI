import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color cardColor = Colors.white;
    final Color cardTitle = Color(0xFF233D85);
    final Color cardDesc = Color(0xFFF47BA3);
    final Color infoBoxColor = Colors.white;
    final Color infoTextColor = Color(0xFF233D85);
    final Color logoPink = Color(0xFFF47BA3);
    final double borderRadius = 20;
    final isWide = MediaQuery.of(context).size.width > 700;
    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FA),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo ve başlık
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsets.only(right: 8, top: 2),
                      child: Icon(Icons.favorite, color: logoPink, size: 36),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sargetek',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF233D85)),
                        ),
                        Text(
                          'Meme Kanseri Tespit',
                          style: TextStyle(fontSize: 14, color: Color(0xFFF47BA3)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // İçerik
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bilgilendirme kutusu
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: infoBoxColor,
                                borderRadius: BorderRadius.circular(borderRadius),
                              ),
                              child: const Center(
                                child: Text(
                                  'Bilgilendirme ya da\naçıklama metni',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Color(0xFF233D85), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // 2x2 grid kartlar
                          Expanded(
                            flex: 3,
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.1,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _HomeCard(
                                  title: 'BI-RADS Analizi',
                                  desc: 'Radyoloji raporlarından BI-RADS kategorisiyle uyumunun kontrolü',
                                  onTap: () => Navigator.pushNamed(context, '/birads'),
                                ),
                                _HomeCard(
                                  title: 'B-Kategori Tahmini',
                                  desc: 'Patoloji raporlarından B kategorisinin tahmini',
                                  onTap: () => Navigator.pushNamed(context, '/bkategori'),
                                ),
                                _HomeCard(
                                  title: 'Uyum Analizi',
                                  desc: 'Radyoloji raporlarından ve patoloji raporlarından uyumluluk analizi',
                                  onTap: () => Navigator.pushNamed(context, '/uyum'),
                                ),
                                _HomeCard(
                                  title: 'Tanı&Tedavi Önerisi',
                                  desc: 'Radyoloji ve patolojik uyumluluğa göre tanı ve tedavi önerilerinin sunulması',
                                  onTap: () => Navigator.pushNamed(context, '/tani'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: infoBoxColor,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: const Center(
                              child: Text(
                                'Bilgilendirme ya da\naçıklama metni',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: Color(0xFF233D85), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 1,
                            shrinkWrap: true,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2.5,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _HomeCard(
                                title: 'BI-RADS Analizi',
                                desc: 'Radyoloji raporlarından BI-RADS kategorisiyle uyumunun kontrolü',
                                onTap: () => Navigator.pushNamed(context, '/birads'),
                              ),
                              _HomeCard(
                                title: 'B-Kategori Tahmini',
                                desc: 'Patoloji raporlarından B kategorisinin tahmini',
                                onTap: () => Navigator.pushNamed(context, '/bkategori'),
                              ),
                              _HomeCard(
                                title: 'Uyum Analizi',
                                desc: 'Radyoloji raporlarından ve patoloji raporlarından uyumluluk analizi',
                                onTap: () => Navigator.pushNamed(context, '/uyum'),
                              ),
                              _HomeCard(
                                title: 'Tanı & Tedavi Önerisi',
                                desc: 'Radyoloji ve patolojik uyumluluğa göre tanı ve tedavi önerilerinin sunulması',
                                onTap: () => Navigator.pushNamed(context, '/tani'),
                              ),
                            ],
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

class _HomeCard extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback onTap;
  const _HomeCard({required this.title, required this.desc, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFF47BA3), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF233D85)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: const TextStyle(fontSize: 11, color: Color(0xFFF47BA3)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.add_circle_outline, color: Color(0xFFF47BA3), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
