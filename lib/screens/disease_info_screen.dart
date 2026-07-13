import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class DiseaseInfoScreen extends StatelessWidget {
  const DiseaseInfoScreen({super.key});
  static const diseases = [
    (
      'Penyakit Mulut dan Kuku (PMK)',
      'Penyakit virus menular yang ditandai demam, luka atau lepuh pada mulut, air liur berlebihan, dan luka di sekitar kuku.',
      'Isolasi ternak, desinfeksi kandang, serta segera hubungi petugas kesehatan hewan.',
    ),
    (
      'Mastitis',
      'Peradangan pada jaringan ambing yang dapat menyebabkan ambing membengkak, nyeri, dan produksi susu menurun.',
      'Jaga kebersihan proses pemerahan dan lakukan terapi sesuai arahan dokter hewan.',
    ),
    (
      'Lumpy Skin Disease',
      'Penyakit virus dengan gejala utama berupa benjolan atau nodul pada kulit, demam, dan penurunan kondisi tubuh.',
      'Isolasi sapi, kendalikan serangga, dan lakukan vaksinasi sesuai program kesehatan hewan.',
    ),
    (
      'Gangguan Pencernaan',
      'Gangguan saluran pencernaan yang dapat menimbulkan diare, nafsu makan menurun, lemas, dan dehidrasi.',
      'Pastikan kecukupan air, evaluasi pakan, dan konsultasikan bila gejala berlanjut.',
    ),
    (
      'Infeksi Pernapasan',
      'Infeksi yang dapat menyebabkan batuk, sesak napas, demam, dan keluarnya lendir dari hidung.',
      'Perbaiki ventilasi kandang, kurangi kepadatan, dan lakukan pemeriksaan dokter hewan.',
    ),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ScreenHeader(title: 'Informasi Penyakit'),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.emeraldLight,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.emeraldDark),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Pelajari gejala umum dan langkah penanganan awal penyakit sapi.',
                  style: TextStyle(color: AppColors.slate600, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ...diseases.map(
          (d) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: AppCard(
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(top: 4),
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.emeraldLight,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: AssetImage('assets/icons/animal.png'),
                    width: 20,
                    height: 20,
                    color: AppColors.emerald,
                  ),
                ),
                title: Text(
                  d.$1,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                children: [
                  Text(
                    d.$2,
                    style: const TextStyle(
                      color: AppColors.emeraldDark,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Penanganan awal: ${d.$3}',
                      style: const TextStyle(
                        color: AppColors.slate600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
