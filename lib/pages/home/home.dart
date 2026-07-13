import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Penyakit Sapi'),
      ),
      body: const Center(
        child: Text('Halaman utama aplikasi'),
      ),
    );
  }
}