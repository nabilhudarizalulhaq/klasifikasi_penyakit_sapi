import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'processing_screen.dart';

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({super.key});
  @override
  State<SymptomScreen> createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  final Set<String> selected = {};
  final List<Cow> cows = [];
  Cow? selectedCow;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadCows();
  }

  Future<void> _loadCows() async {
    final data = await DatabaseService.instance.getCows();
    if (!mounted) return;
    setState(() {
      cows
        ..clear()
        ..addAll(data);
      loading = false;
    });
  }
  static const symptoms = [
    ('demam', 'Demam', 'Suhu tubuh meningkat'),
    ('nafsu-makan', 'Nafsu makan menurun', 'Tidak menghabiskan pakan'),
    ('lemas', 'Tubuh lemas', 'Aktivitas berkurang'),
    ('diare', 'Diare', 'Feses encer atau berair'),
    ('sesak-napas', 'Sesak napas', 'Pernapasan cepat atau berat'),
    ('batuk', 'Batuk', 'Batuk berulang'),
    ('luka-mulut', 'Luka pada mulut', 'Lepuh atau sariawan'),
    ('luka-kuku', 'Luka pada kuku', 'Luka di sela kuku'),
    ('benjolan-kulit', 'Benjolan pada kulit', 'Nodul atau benjolan'),
    ('produksi-susu', 'Produksi susu menurun', 'Penurunan produksi mendadak'),
    ('ambing-bengkak', 'Ambing membengkak', 'Ambing panas atau nyeri'),
    ('mata-berair', 'Mata berair', 'Keluar cairan dari mata'),
    ('hidung-berlendir', 'Hidung berlendir', 'Sekret dari hidung'),
    ('berat-badan', 'Berat badan menurun', 'Penurunan berat badan'),
    ('bulu-kusam', 'Bulu kusam', 'Bulu tidak mengilap'),
    ('pincang', 'Pincang', 'Kesulitan berjalan'),
    ('air-liur', 'Air liur berlebihan', 'Hipersalivasi'),
    ('kejang', 'Kejang', 'Kontraksi otot tidak terkendali'),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ScreenHeader(title: 'Input Gejala'),
    body: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: AppColors.emeraldLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih gejala yang dialami sapi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${selected.length} gejala dipilih',
                style: const TextStyle(color: AppColors.emeraldDark),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
            children: [
              if (loading) ...[
                const LinearProgressIndicator(color: AppColors.emerald),
                const SizedBox(height: 16),
              ],
              if (cows.isNotEmpty) ...[
                DropdownButtonFormField<Cow>(
                  initialValue: selectedCow,
                  decoration: const InputDecoration(
                    labelText: 'Pilih sapi (opsional)',
                  ),
                  items: cows
                      .map(
                        (c) => DropdownMenuItem(value: c, child: Text(c.name)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => selectedCow = v),
                ),
                const SizedBox(height: 16),
              ],
              ...symptoms.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CheckboxListTile(
                    value: selected.contains(s.$1),
                    onChanged: (v) => setState(
                      () => v == true
                          ? selected.add(s.$1)
                          : selected.remove(s.$1),
                    ),
                    title: Text(
                      s.$2,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(s.$3),
                    activeColor: AppColors.emerald,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tileColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    bottomSheet: SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: PrimaryButton(
          label: 'Proses Diagnosis (${selected.length})',
          icon: Icons.monitor_heart_outlined,
          onPressed: selected.isEmpty
              ? null
              : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProcessingScreen(
                      symptoms: selected.toList(),
                      cow: selectedCow,
                    ),
                  ),
                ),
        ),
      ),
    ),
  );
}
