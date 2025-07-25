import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FA),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 950),
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FAFD),
              borderRadius: BorderRadius.circular(32),
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
                      padding: const EdgeInsets.only(right: 12, top: 2),
                      child: Icon(Icons.favorite, color: Color(0xFFF47BA3), size: 54),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sargetek',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Color(0xFFF47BA3)),
                        ),
                        Text(
                          'Meme Kanseri Tespit',
                          style: TextStyle(fontSize: 18, color: Color(0xFFF47BA3)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bilgilendirme kutusu
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Bilgilendirme ya da\naçıklama metni',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20, color: Color(0xFF233D85), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                          // 2x2 grid kartlar
                          Expanded(
                            flex: 3,
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              childAspectRatio: 1.1,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _HomeCard(
                                  title: 'BI-RADS Analizi',
                                  desc: 'Radyoloji raporlarının BI-RADS kategorisiyle uyumunun kontrolü',
                                  onTap: () => Navigator.pushNamed(context, '/birads'),
                                ),
                                _HomeCard(
                                  title: 'Patoloji B-Kategori Tahmini',
                                  desc: 'Patoloji raporlarından B kategorisinin tahmini',
                                  onTap: () => Navigator.pushNamed(context, '/bkategori'),
                                ),
                                _HomeCard(
                                  title: 'B Kategori Sistemi Üzerinden Uyum Analizi',
                                  desc: 'Radyoloji raporlarının BI-RADS kategorisi ile Patoloji raporlarının B kategorisi ile karşılaştırılması',
                                  onTap: () => Navigator.pushNamed(context, '/uyum'),
                                ),
                                _HomeCard(
                                  title: 'Radyolojik-Patolojik Uyumluluk Analizi & Tanı ve Tedavi Önerisi',
                                  desc: 'Radyolojik ve patolojik uyumluluğa göre tanı ve tedavi önerilerinin sunulması',
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
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Bilgilendirme ya da\naçıklama metni',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Color(0xFF233D85), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 1,
                            shrinkWrap: true,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 2.5,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _HomeCard(
                                title: 'BI-RADS Analizi',
                                desc: 'Radyoloji raporlarının BI-RADS kategorisiyle uyumunun kontrolü',
                                onTap: () => Navigator.pushNamed(context, '/birads'),
                              ),
                              _HomeCard(
                                title: 'B-Kategori Tahmini',
                                desc: 'Patoloji raporlarından B kategorisinin tahmini',
                                onTap: () => Navigator.pushNamed(context, '/bkategori'),
                              ),
                              _HomeCard(
                                title: 'Uyum Analizi',
                                desc: 'Radyoloji raporlarından ve patoloji raporlarından B kategorisinin tahmini',
                                onTap: () => Navigator.pushNamed(context, '/uyum'),
                              ),
                              _HomeCard(
                                title: 'Tanı & Tedavi Önerisi',
                                desc: 'Radyolojik ve patolojik uyumluluğa göre tanı ve tedavi önerilerinin sunulması',
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
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF233D85)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    desc,
                    style: const TextStyle(fontSize: 13, color: Color(0xFFF47BA3)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Color(0xFF233D85), size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
