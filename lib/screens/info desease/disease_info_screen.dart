import 'package:flutter/material.dart';
import 'package:klasifikasi_penyakit_sapi/screens/info%20desease/disease_info_data.dart';
import 'package:klasifikasi_penyakit_sapi/screens/info%20desease/disease_info_model.dart';
import 'package:klasifikasi_penyakit_sapi/theme/app_theme.dart';
import 'package:klasifikasi_penyakit_sapi/widgets/common_widgets.dart';


class DiseaseInfoScreen extends StatelessWidget {
  const DiseaseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const ScreenHeader(
        title: 'Informasi Penyakit',
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        itemCount: diseaseInfoData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final disease = diseaseInfoData[index];

          return _DiseaseCard(
            disease: disease,
            onTap: () => _showDiseaseDetail(
              context,
              disease,
            ),
          );
        },
      ),
    );
  }

  void _showDiseaseDetail(
    BuildContext context,
    DiseaseInfo disease,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _DiseaseDetailSheet(
          disease: disease,
        );
      },
    );
  }
}

class _DiseaseCard extends StatelessWidget {
  const _DiseaseCard({
    required this.disease,
    required this.onTap,
  });

  final DiseaseInfo disease;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final config = disease.severity.config;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFF1F5F9),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: config.backgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  disease.icon,
                  color: config.foregroundColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease.name,
                      style: const TextStyle(
                        color: AppColors.slate800,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      disease.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.slate500,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 9),
                    _SeverityBadge(
                      config: config,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(top: 14),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.slate500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiseaseDetailSheet extends StatelessWidget {
  const _DiseaseDetailSheet({
    required this.disease,
  });

  final DiseaseInfo disease;

  @override
  Widget build(BuildContext context) {
    final config = disease.severity.config;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.55,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Detail Penyakit',
                        style: TextStyle(
                          color: AppColors.slate800,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: config.backgroundColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  disease.icon,
                                  color: config.foregroundColor,
                                ),
                              ),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      disease.name,
                                      style: TextStyle(
                                        color: config.foregroundColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    _SeverityBadge(config: config),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            disease.description,
                            style: const TextStyle(
                              color: AppColors.slate700,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _DetailSection(
                      title: 'Gejala Umum',
                      items: disease.symptoms,
                      type: DetailSectionType.bullet,
                    ),
                    const SizedBox(height: 24),
                    _DetailSection(
                      title: 'Pencegahan',
                      items: disease.prevention,
                      type: DetailSectionType.prevention,
                    ),
                    const SizedBox(height: 24),
                    _DetailSection(
                      title: 'Penanganan Awal',
                      items: disease.treatment,
                      type: DetailSectionType.treatment,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.items,
    required this.type,
  });

  final String title;
  final List<String> items;
  final DetailSectionType type;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (type) {
      DetailSectionType.bullet => const Color(0xFFF8FAFC),
      DetailSectionType.prevention => const Color(0xFFEFF6FF),
      DetailSectionType.treatment => const Color(0xFFF0FDF4),
    };

    final accentColor = switch (type) {
      DetailSectionType.bullet => AppColors.emerald,
      DetailSectionType.prevention => const Color(0xFF2563EB),
      DetailSectionType.treatment => const Color(0xFF16A34A),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.slate800,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          items.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == DetailSectionType.bullet)
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(
                        top: 6,
                        right: 11,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(right: 11),
                      child: Text(
                        '${index + 1}.',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      items[index],
                      style: const TextStyle(
                        color: AppColors.slate700,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge({
    required this.config,
  });

  final SeverityConfig config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: config.badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          color: config.foregroundColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}