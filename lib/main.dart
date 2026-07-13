import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DiagnosisSapiApp());
}

class DiagnosisSapiApp extends StatelessWidget {
  const DiagnosisSapiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Diagnosis Penyakit Sapi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light.copyWith(
        textTheme: GoogleFonts.interTextTheme(AppTheme.light.textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}
