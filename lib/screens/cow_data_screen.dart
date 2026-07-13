import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class CowDataScreen extends StatefulWidget {
  const CowDataScreen({super.key});

  @override
  State<CowDataScreen> createState() => _CowDataScreenState();
}

class _CowDataScreenState extends State<CowDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final List<Cow> _cows = [];

  String _gender = 'Betina';
  String _type = 'Sapi Perah';
  bool _showForm = false;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadCows();
  }

  Future<void> _loadCows() async {
    final cows = await DatabaseService.instance.getCows();
    if (!mounted) return;
    setState(() {
      _cows
        ..clear()
        ..addAll(cows);
      _loading = false;
    });
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false) || _saving) return;
    setState(() => _saving = true);

    try {
      await DatabaseService.instance.insertCow(
        Cow(
          name: _name.text.trim(),
          age: int.parse(_age.text),
          gender: _gender,
          type: _type,
        ),
      );
      _name.clear();
      _age.clear();
      _gender = 'Betina';
      _type = 'Sapi Perah';
      _showForm = false;
      await _loadCows();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data sapi berhasil disimpan')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete(Cow cow) async {
    if (cow.id == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Data Sapi'),
        content: Text('Hapus data sapi ${cow.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await DatabaseService.instance.deleteCow(cow.id!);
    await _loadCows();
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: ScreenHeader(
          title: 'Data Sapi Saya',
          actions: [
            IconButton(
              onPressed: () => setState(() => _showForm = !_showForm),
              icon: Icon(_showForm ? Icons.close : Icons.add_circle_outline),
            ),
          ],
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadCows,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(24),
                  children: [
                    if (_showForm) ...[
                      AppCard(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tambah Data Sapi',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: _name,
                                decoration: const InputDecoration(
                                  labelText: 'Nama Sapi',
                                  hintText: 'Contoh: Bella',
                                ),
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                        ? 'Nama sapi wajib diisi'
                                        : null,
                              ),
                              const SizedBox(height: 14),
                              TextFormField(
                                controller: _age,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Umur (bulan)',
                                  hintText: 'Contoh: 24',
                                ),
                                validator: (value) {
                                  final age = int.tryParse(value ?? '');
                                  if (age == null || age <= 0) {
                                    return 'Masukkan umur yang valid';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                              DropdownButtonFormField<String>(
                                value: _gender,
                                decoration: const InputDecoration(
                                  labelText: 'Jenis Kelamin',
                                ),
                                items: const ['Betina', 'Jantan']
                                    .map(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _gender = value);
                                  }
                                },
                              ),
                              const SizedBox(height: 14),
                              DropdownButtonFormField<String>(
                                value: _type,
                                decoration: const InputDecoration(
                                  labelText: 'Jenis Sapi',
                                ),
                                items: const [
                                  'Sapi Perah',
                                  'Sapi Potong',
                                  'Sapi Lokal',
                                ]
                                    .map(
                                      (value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _type = value);
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                label: _saving ? 'Menyimpan...' : 'Simpan Data',
                                icon: Icons.save_outlined,
                                onPressed: _saving ? null : _save,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                    if (_cows.isEmpty)
                      AppCard(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.storage_outlined,
                              size: 58,
                              color: AppColors.emerald,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Belum Ada Data Sapi',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 18),
                            PrimaryButton(
                              label: 'Tambah Data Sapi',
                              icon: Icons.add,
                              onPressed: () =>
                                  setState(() => _showForm = true),
                            ),
                          ],
                        ),
                      )
                    else
                      ..._cows.map(
                        (cow) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: AppCard(
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColors.emeraldLight,
                                  child: Icon(
                                    Icons.pets,
                                    color: AppColors.emerald,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cow.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${cow.type} • ${cow.gender} • ${cow.age} bulan',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.slate500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _delete(cow),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
        floatingActionButton: _cows.isNotEmpty
            ? FloatingActionButton(
                onPressed: () => setState(() => _showForm = true),
                backgroundColor: AppColors.emerald,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              )
            : null,
      );
}
