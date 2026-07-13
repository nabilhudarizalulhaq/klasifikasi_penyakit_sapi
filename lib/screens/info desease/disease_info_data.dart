import 'package:flutter/material.dart';
import 'package:klasifikasi_penyakit_sapi/screens/info%20desease/disease_info_model.dart';



const List<DiseaseInfo> diseaseInfoData = [
  DiseaseInfo(
    id: 'pmk',
    name: 'Penyakit Mulut dan Kuku (PMK)',
    icon: Icons.monitor_heart_outlined,
    severity: DiseaseSeverity.high,
    description:
        'Penyakit virus yang sangat menular pada hewan berkuku belah, '
        'ditandai dengan lesi dan lepuh pada mulut, kuku, dan ambing.',
    symptoms: [
      'Demam tinggi (40–41°C)',
      'Lepuh dan luka di mulut dan lidah',
      'Luka pada kuku dan celah kuku',
      'Air liur berlebihan',
      'Pincang dan kesulitan berjalan',
      'Nafsu makan menurun drastis',
    ],
    prevention: [
      'Vaksinasi rutin sesuai jadwal',
      'Karantina hewan baru minimal 21 hari',
      'Desinfeksi kandang dan peralatan',
      'Batasi kontak dengan hewan lain',
      'Jaga kebersihan kandang',
      'Laporkan ke dinas peternakan jika terdeteksi',
    ],
    treatment: [
      'Isolasi segera hewan yang terinfeksi',
      'Hubungi dokter hewan untuk penanganan',
      'Berikan pakan lunak yang mudah dimakan',
      'Aplikasikan antiseptik pada luka',
      'Berikan vitamin dan suplemen pendukung',
      'Pantau kondisi hewan secara ketat',
    ],
  ),
  DiseaseInfo(
    id: 'mastitis',
    name: 'Mastitis',
    icon: Icons.water_drop_outlined,
    severity: DiseaseSeverity.medium,
    description:
        'Peradangan pada kelenjar ambing yang biasanya disebabkan oleh '
        'infeksi bakteri, sehingga menurunkan produksi dan kualitas susu.',
    symptoms: [
      'Ambing bengkak dan terasa panas',
      'Nyeri saat disentuh',
      'Produksi susu menurun',
      'Susu berubah warna atau tekstur',
      'Demam ringan hingga sedang',
      'Penurunan nafsu makan',
    ],
    prevention: [
      'Jaga kebersihan saat proses pemerahan',
      'Desinfeksi puting sebelum dan sesudah perah',
      'Gunakan peralatan perah yang bersih',
      'Lakukan pemeriksaan ambing rutin',
      'Pastikan ventilasi kandang baik',
      'Berikan nutrisi yang cukup',
    ],
    treatment: [
      'Periksa ambing secara menyeluruh',
      'Konsultasi dengan dokter hewan',
      'Pemberian antibiotik sesuai resep dokter',
      'Perah susu lebih sering untuk membantu drainase',
      'Kompres hangat pada area yang bengkak',
      'Pisahkan susu dari sapi yang terinfeksi',
    ],
  ),
  DiseaseInfo(
    id: 'lsd',
    name: 'Lumpy Skin Disease',
    icon: Icons.warning_amber_rounded,
    severity: DiseaseSeverity.high,
    description:
        'Penyakit virus yang menyebabkan benjolan keras pada kulit sapi '
        'dan dapat menurunkan produktivitas serta kualitas kulit.',
    symptoms: [
      'Benjolan atau nodul keras pada kulit',
      'Demam tinggi',
      'Penurunan produksi susu',
      'Pembengkakan limfatik',
      'Lesi pada membran mukosa',
      'Nafsu makan menurun',
    ],
    prevention: [
      'Vaksinasi pencegahan',
      'Kontrol serangga penular seperti lalat dan nyamuk',
      'Karantina hewan yang sakit',
      'Jaga kebersihan lingkungan kandang',
      'Hindari kontak dengan hewan terinfeksi',
      'Laporkan kasus segera kepada pihak berwenang',
    ],
    treatment: [
      'Isolasi hewan yang terinfeksi',
      'Konsultasi dengan dokter hewan segera',
      'Rawat luka menggunakan antiseptik',
      'Berikan vitamin dan imunostimulan',
      'Lakukan terapi simptomatik sesuai kondisi',
      'Vaksinasi hewan sehat lainnya',
    ],
  ),
  DiseaseInfo(
    id: 'pencernaan',
    name: 'Gangguan Pencernaan',
    icon: Icons.monitor_heart_outlined,
    severity: DiseaseSeverity.low,
    description:
        'Gangguan pada sistem pencernaan sapi yang dapat disebabkan oleh '
        'perubahan pakan, infeksi, atau masalah metabolisme.',
    symptoms: [
      'Diare atau feses abnormal',
      'Nafsu makan menurun',
      'Kembung atau bloat',
      'Dehidrasi',
      'Penurunan berat badan',
      'Lemah dan lesu',
    ],
    prevention: [
      'Berikan pakan berkualitas baik',
      'Hindari perubahan pakan secara mendadak',
      'Sediakan air bersih yang cukup',
      'Jaga kebersihan tempat pakan',
      'Berikan probiotik secara rutin',
      'Pantau kondisi kesehatan setiap hari',
    ],
    treatment: [
      'Puasakan sementara atau kurangi pakan',
      'Berikan air minum yang cukup',
      'Konsultasikan kepada dokter hewan jika kondisi parah',
      'Berikan pakan berserat tinggi secara bertahap',
      'Berikan elektrolit untuk mengatasi dehidrasi',
      'Pantau perkembangan kondisi sapi',
    ],
  ),
  DiseaseInfo(
    id: 'pernapasan',
    name: 'Infeksi Pernapasan',
    icon: Icons.air_outlined,
    severity: DiseaseSeverity.medium,
    description:
        'Infeksi pada sistem pernapasan yang dapat disebabkan oleh bakteri, '
        'virus, atau kondisi lingkungan kandang yang buruk.',
    symptoms: [
      'Batuk dan bersin',
      'Sesak napas atau napas cepat',
      'Keluar cairan dari hidung',
      'Demam',
      'Nafsu makan menurun',
      'Lemah dan tidak aktif',
    ],
    prevention: [
      'Pastikan ventilasi kandang baik',
      'Hindari kepadatan kandang berlebih',
      'Jaga kebersihan kandang',
      'Kurangi stres pada hewan',
      'Lakukan vaksinasi sesuai program',
      'Isolasi hewan yang sakit',
    ],
    treatment: [
      'Pindahkan sapi ke area dengan ventilasi baik',
      'Konsultasikan dengan dokter hewan',
      'Berikan antibiotik jika diresepkan',
      'Berikan terapi suportif seperti vitamin dan mineral',
      'Pantau suhu tubuh secara rutin',
      'Jaga kandang tetap bersih dan kering',
    ],
  ),
];