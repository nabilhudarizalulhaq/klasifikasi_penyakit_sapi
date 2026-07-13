import 'package:flutter/material.dart';

import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'about_screen.dart';
import 'cow_data_screen.dart';
import 'disease_info_screen.dart';
import 'history_screen.dart';
import 'symptom_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cowCount = 0;
  int _historyCount = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    try {
      final results = await Future.wait([
        DatabaseService.instance.countCows(),
        DatabaseService.instance.countHistory(),
      ]);
      if (!mounted) return;
      setState(() {
        _cowCount = results[0];
        _historyCount = results[1];
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _open(Widget page) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    if (mounted) await _loadSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 85),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.emerald, AppColors.emeraldDark],
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Sistem diagnosis kesehatan ternak sapi',
                        style: TextStyle(
                          color: Color(0xFFD1FAE5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: -48,
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Total Diagnosis',
                          value: _loading ? '...' : '$_historyCount',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _StatCard(
                          label: 'Sapi Terdaftar',
                          value: _loading ? '...' : '$_cowCount',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 68),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadSummary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Menu Utama',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.slate700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.15,
                        children: [
                          _MenuCard(
                            title: 'Mulai Diagnosis',
                            icon: Icons.monitor_heart_outlined,
                            color: AppColors.emerald,
                            onTap: () => _open(const SymptomScreen()),
                          ),
                          _MenuCard(
                            title: 'Data Sapi',
                            icon: Icons.storage_outlined,
                            color: Colors.blue,
                            onTap: () => _open(const CowDataScreen()),
                          ),
                          _MenuCard(
                            title: 'Riwayat',
                            icon: Icons.history,
                            color: Colors.orange,
                            onTap: () => _open(const HistoryScreen()),
                          ),
                          _MenuCard(
                            title: 'Informasi Penyakit',
                            icon: Icons.info_outline,
                            color: Colors.purple,
                            onTap: () => _open(const DiseaseInfoScreen()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Informasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.slate700,
                        ),
                      ),
                      const SizedBox(height: 14),
                      AppCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColors.emerald.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: AppColors.emerald,
                            ),
                          ),
                          title: const Text(
                            'Tentang Aplikasi',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate700,
                            ),
                          ),
                          subtitle: const Text(
                            'Informasi sistem diagnosis penyakit sapi',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _open(const AboutScreen()),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.emerald.withValues(alpha: 0.1),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.emerald, size: 30),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.monitor_heart_outlined,
              color: AppColors.emerald,
              size: 30,
            ),
            label: 'Diagnosis',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.storage_outlined,
              color: AppColors.emerald,
              size: 30,
            ),
            label: 'Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.history, color: AppColors.emerald, size: 30),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline, color: AppColors.emerald, size: 30),
            label: 'Info',
          ),
        ],
        onDestinationSelected: (index) {
          if (index == 1) _open(const SymptomScreen());
          if (index == 2) _open(const CowDataScreen());
          if (index == 3) _open(const HistoryScreen());
          if (index == 4) _open(const DiseaseInfoScreen());
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.slate500),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppColors.emerald,
          ),
        ),
      ],
    ),
  );
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.slate700,
            ),
          ),
        ],
      ),
    ),
  );
}
