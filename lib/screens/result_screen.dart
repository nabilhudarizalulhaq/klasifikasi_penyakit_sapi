import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.result,
    required this.cow,
  });

  final DiagnosisResult result;
  final Cow? cow;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool saved = false;
  bool saving = false;

  Color get severityColor => widget.result.severity == 'Tinggi'
      ? Colors.red
      : widget.result.severity == 'Sedang'
          ? Colors.orange
          : AppColors.emerald;

  Future<void> _save() async {
    if (saved || saving) return;
    setState(() => saving = true);

    try {
      await DatabaseService.instance.insertHistory(
        DiagnosisHistory(
          date: DateTime.now(),
          cowId: widget.cow?.id,
          cowName: widget.cow?.name ?? 'Sapi Tidak Diketahui',
          result: widget.result,
        ),
      );
      if (!mounted) return;
      setState(() => saved = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hasil diagnosis berhasil disimpan')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan diagnosis: $error')),
      );
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const ScreenHeader(title: 'Hasil Diagnosis'),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            AppCard(
              color: AppColors.emeraldLight,
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: AppColors.emerald,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.health_and_safety_outlined,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Hasil Prediksi',
                    style: TextStyle(color: AppColors.slate500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.result.disease,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.slate800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    children: [
                      Chip(
                        label: Text('Akurasi ${widget.result.confidence}%'),
                        backgroundColor: Colors.white,
                      ),
                      Chip(
                        label: Text('Risiko ${widget.result.severity}'),
                        backgroundColor: severityColor.withValues(alpha: .12),
                        labelStyle: TextStyle(
                          color: severityColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gejala yang Dipilih',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.result.symptoms
                        .map(
                          (value) => Chip(
                            label: Text(value.replaceAll('-', ' ')),
                            backgroundColor: const Color(0xFFF1F5F9),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rekomendasi Penanganan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  ...widget.result.recommendations.asMap().entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.emeraldLight,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${entry.key + 1}',
                                  style: const TextStyle(
                                    color: AppColors.emeraldDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    color: AppColors.slate600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFED7AA)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Hasil ini merupakan prediksi awal dan tidak menggantikan pemeriksaan langsung oleh dokter hewan.',
                      style: TextStyle(color: AppColors.slate600, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: saved
                  ? 'Hasil Telah Disimpan'
                  : saving
                      ? 'Menyimpan...'
                      : 'Simpan Hasil Diagnosis',
              icon: saved ? Icons.check : Icons.save_outlined,
              onPressed: saved || saving ? null : _save,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      );
}
