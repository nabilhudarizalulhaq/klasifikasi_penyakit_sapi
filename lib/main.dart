import 'package:flutter/material.dart';
import 'package:klasifikasi_penyakit_sapi/pages/home/home.dart';
import 'package:klasifikasi_penyakit_sapi/pages/splash/splash.dart';


void main() {
  runApp(const DiagnosisSapiApp());
}

class DiagnosisSapiApp extends StatelessWidget {
  const DiagnosisSapiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Diagnosis Penyakit Sapi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
        ),
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Diagnosis Penyakit Sapi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

