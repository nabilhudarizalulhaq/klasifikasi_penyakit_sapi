import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'about_screen.dart';
import 'cow_data_screen.dart';
import 'disease_info_screen.dart';
import 'history_screen.dart';
import 'symptom_screen.dart';

class HomeScreen extends StatefulWidget { const HomeScreen({super.key}); @override State<HomeScreen> createState() => _HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen> {
  final List<Cow> cows = [];
  final List<DiagnosisHistory> history = [];

  Future<void> _open(Widget page) async { await Navigator.push(context, MaterialPageRoute(builder: (_) => page)); if (mounted) setState(() {}); }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.fromLTRB(24, 28, 24, 34), decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.emerald, AppColors.emeraldDark])), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Selamat Datang', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('Sistem diagnosis kesehatan ternak sapi', style: TextStyle(color: Color(0xFFD1FAE5), fontSize: 14))])),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(24, 0, 24, 28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Transform.translate(offset: const Offset(0, -20), child: Row(children: [Expanded(child: _StatCard(label: 'Total Diagnosis', value: '${history.length}')), const SizedBox(width: 14), Expanded(child: _StatCard(label: 'Sapi Terdaftar', value: '${cows.length}'))])),
          const Text('Menu Utama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.slate700)),
          const SizedBox(height: 14),
          GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 1.08, children: [
            _MenuCard(title: 'Diagnosis Penyakit', icon: Icons.monitor_heart_outlined, color: AppColors.emerald, onTap: () => _open(SymptomScreen(cows: cows, history: history))),
            _MenuCard(title: 'Data Sapi', icon: Icons.storage_outlined, color: Colors.blue, onTap: () => _open(CowDataScreen(cows: cows))),
            _MenuCard(title: 'Riwayat Diagnosis', icon: Icons.history, color: Colors.purple, onTap: () => _open(HistoryScreen(history: history))),
            _MenuCard(title: 'Informasi Penyakit', icon: Icons.info_outline, color: Colors.orange, onTap: () => _open(const DiseaseInfoScreen())),
            _MenuCard(title: 'Tentang Aplikasi', icon: Icons.menu_book_outlined, color: AppColors.slate600, onTap: () => _open(const AboutScreen())),
          ]),
        ]))),
      ]),
    ),
    bottomNavigationBar: NavigationBar(selectedIndex: 0, destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'), NavigationDestination(icon: Icon(Icons.monitor_heart_outlined), label: 'Diagnosis'), NavigationDestination(icon: Icon(Icons.storage_outlined), label: 'Data'), NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'), NavigationDestination(icon: Icon(Icons.info_outline), label: 'Info')], onDestinationSelected: (i) { if(i==1) _open(SymptomScreen(cows:cows, history:history)); if(i==2) _open(CowDataScreen(cows:cows)); if(i==3) _open(HistoryScreen(history:history)); if(i==4) _open(const DiseaseInfoScreen()); }),
  );
}

class _StatCard extends StatelessWidget { const _StatCard({required this.label, required this.value}); final String label,value; @override Widget build(BuildContext context)=>AppCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:const TextStyle(fontSize:12,color:AppColors.slate500)),const SizedBox(height:5),Text(value,style:const TextStyle(fontSize:30,fontWeight:FontWeight.w800,color:AppColors.emerald))])); }
class _MenuCard extends StatelessWidget { const _MenuCard({required this.title,required this.icon,required this.color,required this.onTap}); final String title; final IconData icon; final Color color; final VoidCallback onTap; @override Widget build(BuildContext context)=>InkWell(onTap:onTap,borderRadius:BorderRadius.circular(20),child:AppCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:48,height:48,decoration:BoxDecoration(color:color.withValues(alpha:.1),borderRadius:BorderRadius.circular(14)),child:Icon(icon,color:color)),const Spacer(),Text(title,style:const TextStyle(fontSize:14,fontWeight:FontWeight.w600,color:AppColors.slate700))]))); }
