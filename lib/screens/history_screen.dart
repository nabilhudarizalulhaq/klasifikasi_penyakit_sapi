import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<DiagnosisHistory> _history = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await DatabaseService.instance.getHistory();
    if (!mounted) return;
    setState(() {
      _history
        ..clear()
        ..addAll(data);
      _loading = false;
    });
  }

  Future<void> _delete(DiagnosisHistory history) async {
    if (history.id == null) return;
    await DatabaseService.instance.deleteHistory(history.id!);
    await _loadHistory();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const ScreenHeader(title: 'Riwayat Diagnosis'),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadHistory,
                child: _history.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(28),
                        children: const [
                          SizedBox(height: 120),
                          AppCard(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 58,
                                  color: AppColors.slate400,
                                ),
                                SizedBox(height: 14),
                                Text(
                                  'Belum Ada Riwayat',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Hasil diagnosis yang disimpan akan tampil di halaman ini.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.slate500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        itemCount: _history.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final history = _history[index];
                          final date =
                              '${history.date.day.toString().padLeft(2, '0')}/${history.date.month.toString().padLeft(2, '0')}/${history.date.year}';
                          return Dismissible(
                            key: ValueKey(history.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (_) => showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Hapus Riwayat'),
                                content: const Text(
                                  'Riwayat diagnosis ini akan dihapus permanen.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Batal'),
                                  ),
                                  FilledButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (_) => _delete(history),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                            ),
                            child: AppCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          history.cowName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        date,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.slate400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    history.result.disease,
                                    style: const TextStyle(
                                      color: AppColors.emeraldDark,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Keyakinan ${history.result.confidence}% • Risiko ${history.result.severity}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.slate500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
      );
}
