import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }
  @override void dispose() { _timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Color(0xFFECFDF5), Color(0xFFD1FAE5)])),
      child: SafeArea(
        child: Stack(children: [
          Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 116, height: 116, decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle), child: const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 62)),
              const SizedBox(height: 26),
              const Text('Sistem Diagnosis', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: AppColors.slate800)),
              const Text('Penyakit Sapi', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: AppColors.emerald)),
              const SizedBox(height: 12),
              const Text('Solusi Cepat Diagnosis Kesehatan Ternak', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.slate600)),
              const SizedBox(height: 34),
              const Icon(Icons.pets_outlined, size: 82, color: AppColors.emerald),
            ]),
          )),
          const Positioned(left: 0, right: 0, bottom: 24, child: Text('Versi 1.0.0', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.slate400))),
        ]),
      ),
    ),
  );
}
