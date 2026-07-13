import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ScreenHeader(title: 'Tentang Aplikasi'),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 10),
        Center(
          child: Column(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.emerald,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.health_and_safety_outlined,
                  color: Colors.white,
                  size: 52,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sistem Diagnosis',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
              ),
              const Text(
                'Penyakit Sapi',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: AppColors.emerald,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Versi 1.0.0',
                style: TextStyle(color: AppColors.slate400),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const _AboutCard(
          icon: Icons.monitor_heart_outlined,
          title: 'Deskripsi Aplikasi',
          content:
              'Aplikasi mobile untuk membantu peternak dan praktisi peternakan melakukan deteksi awal penyakit sapi berdasarkan gejala klinis yang dipilih.',
        ),
        const SizedBox(height: 14),
        const _AboutCard(
          icon: Icons.account_tree_outlined,
          title: 'Metode yang Digunakan',
          content:
              'Sistem menggunakan algoritma Decision Tree untuk mengklasifikasikan gejala ke dalam diagnosis penyakit yang paling mungkin. Hasil aplikasi tetap harus dikonfirmasi oleh dokter hewan.',
        ),
        const SizedBox(height: 14),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Tujuan Aplikasi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...[
                'Membantu deteksi dini penyakit sapi',
                'Memberikan rekomendasi penanganan awal',
                'Mempercepat pencatatan hasil diagnosis',
                'Meningkatkan perhatian terhadap kesehatan ternak',
              ].map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(
                          color: AppColors.emerald,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e,
                          style: const TextStyle(color: AppColors.slate600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const _AboutCard(
          icon: Icons.school_outlined,
          title: 'Informasi Pengembang',
          content:
              'Dikembangkan sebagai aplikasi penelitian klasifikasi penyakit sapi berbasis mobile. Tahun pengembangan: 2026.',
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            '© 2026 Sistem Diagnosis Penyakit Sapi',
            style: TextStyle(fontSize: 12, color: AppColors.slate400),
          ),
        ),
        const SizedBox(height: 18),
      ],
    ),
  );
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.icon,
    required this.title,
    required this.content,
  });
  final IconData icon;
  final String title, content;
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.emerald),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(color: AppColors.slate600, height: 1.55),
        ),
      ],
    ),
  );
}
