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
            constraints: const BoxConstraints(maxWidth: 1200),
            height: 580,
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAFF),
              borderRadius: BorderRadius.circular(40),
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
                const SizedBox(height: 40),
                // 3 sekme kartları - tam genişlik
                isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _HomeCard(
                              title: 'Patoloji B-Kategori Tahmini',
                              desc: 'Patoloji raporlarından B kategorisinin tahmini',
                              onTap: () => Navigator.pushNamed(context, '/bkategori'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _HomeCard(
                              title: 'B Kategori Sistemi Üzerinden Uyum Analizi',
                              desc: 'Radyoloji raporlarının BI-RADS kategorisi ile Patoloji raporlarının B kategorisi ile karşılaştırılması',
                              onTap: () => Navigator.pushNamed(context, '/uyum'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _HomeCard(
                              title: 'Radyolojik-Patolojik Uyumluluk Analizi & Tanı ve Tedavi Önerisi',
                              desc: 'Radyolojik ve patolojik uyumluluğa göre tanı ve tedavi önerilerinin sunulması',
                              onTap: () => Navigator.pushNamed(context, '/tani'),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _HomeCard(
                            title: 'Patoloji B-Kategori Tahmini',
                            desc: 'Patoloji raporlarından B kategorisinin tahmini',
                            onTap: () => Navigator.pushNamed(context, '/bkategori'),
                          ),
                          const SizedBox(height: 8),
                          _HomeCard(
                            title: 'B Kategori Sistemi Üzerinden Uyum Analizi',
                            desc: 'Radyoloji raporlarının BI-RADS kategorisi ile Patoloji raporlarının B kategorisi ile karşılaştırılması',
                            onTap: () => Navigator.pushNamed(context, '/uyum'),
                          ),
                          const SizedBox(height: 8),
                          _HomeCard(
                            title: 'Radyolojik-Patolojik Uyumluluk Analizi & Tanı ve Tedavi Önerisi',
                            desc: 'Radyolojik ve patolojik uyumluluğa göre tanı ve tedavi önerilerinin sunulması',
                            onTap: () => Navigator.pushNamed(context, '/tani'),
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
  const _HomeCard({
    required this.title,
    required this.desc,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 260, // Büyütüldü
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22, // Büyütüldü
                  color: Color(0xFF233D85),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 16, // Büyütüldü
                  color: Color(0xFFF47BA3),
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
