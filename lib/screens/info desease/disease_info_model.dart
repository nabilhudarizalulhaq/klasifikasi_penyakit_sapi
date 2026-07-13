import 'package:flutter/material.dart';

enum DiseaseSeverity {
  high,
  medium,
  low,
}

class SeverityConfig {
  const SeverityConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.badgeColor,
    required this.label,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color badgeColor;
  final String label;
}

extension DiseaseSeverityExtension on DiseaseSeverity {
  SeverityConfig get config {
    switch (this) {
      case DiseaseSeverity.high:
        return const SeverityConfig(
          backgroundColor: Color(0xFFFEF2F2),
          foregroundColor: Color(0xFFB91C1C),
          badgeColor: Color(0xFFFEE2E2),
          label: 'Bahaya Tinggi',
        );

      case DiseaseSeverity.medium:
        return const SeverityConfig(
          backgroundColor: Color(0xFFFFF7ED),
          foregroundColor: Color(0xFFC2410C),
          badgeColor: Color(0xFFFFEDD5),
          label: 'Bahaya Sedang',
        );

      case DiseaseSeverity.low:
        return const SeverityConfig(
          backgroundColor: Color(0xFFF0FDF4),
          foregroundColor: Color(0xFF15803D),
          badgeColor: Color(0xFFDCFCE7),
          label: 'Bahaya Rendah',
        );
    }
  }
}

class DiseaseInfo {
  const DiseaseInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.severity,
    required this.description,
    required this.symptoms,
    required this.prevention,
    required this.treatment,
  });

  final String id;
  final String name;
  final IconData icon;
  final DiseaseSeverity severity;
  final String description;
  final List<String> symptoms;
  final List<String> prevention;
  final List<String> treatment;
}

enum DetailSectionType {
  bullet,
  prevention,
  treatment,
}