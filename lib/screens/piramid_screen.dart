import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PiramidScreen extends StatefulWidget {
  const PiramidScreen({super.key});

  @override
  State<PiramidScreen> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidScreen> {
  final _alasCtrl = TextEditingController();
  final _tinggiCtrl = TextEditingController();
  Map<String, double>? _hasil;
  String _error = '';

  void _hitung() {
    final alas = double.tryParse(_alasCtrl.text.trim());
    final tinggi = double.tryParse(_tinggiCtrl.text.trim());
    if (alas == null || tinggi == null || alas <= 0 || tinggi <= 0) {
      setState(() {
        _error = 'Masukkan nilai alas dan tinggi yang valid!';
        _hasil = null;
      });
      return;
    }
    final luasAlas = alas * alas;
    final apotema = sqrt(tinggi * tinggi + (alas / 2) * (alas / 2));
    final luasSelimut = 4 * 0.5 * alas * apotema;
    final luasPermukaan = luasAlas + luasSelimut;
    final volume = (1 / 3) * luasAlas * tinggi;
    setState(() {
      _error = '';
      _hasil = {
        'Luas Alas': luasAlas,
        'Apotema': apotema,
        'Luas Selimut': luasSelimut,
        'Luas Permukaan': luasPermukaan,
        'Volume': volume,
      };
    });
  }

  String _fmt(double n) =>
      n == n.truncateToDouble() ? n.toInt().toString() : n.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bg,
      appBar: AppBar(
        //backgroundColor: AppColors.green.withOpacity(0.1),
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Luas & Volume Piramid',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Info rumus
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.green.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.change_history_rounded,
                    color: AppColors.green,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Piramid Persegi',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrim,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _RumusRow('Luas Permukaan', 'Luas Alas + Luas Selimut'),
                  _RumusRow('Volume', '¹⁄₃ × Luas Alas × Tinggi'),
                  _RumusRow('Apotema', '√(t² + (s/2)²)'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel('PANJANG SISI ALAS'),
            const SizedBox(height: 6),
            _buildInput(_alasCtrl, 'Contoh: 6', 'cm'),
            const SizedBox(height: 12),
            _buildLabel('TINGGI PIRAMID'),
            const SizedBox(height: 6),
            _buildInput(_tinggiCtrl, 'Contoh: 8', 'cm'),

            if (_error.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _error,
                style: const TextStyle(color: AppColors.red, fontSize: 12),
              ),
            ],
            const SizedBox(height: 16),

            GestureDetector(
              onTap: _hitung,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.green.withOpacity(0.3)),
                ),
                child: const Text(
                  'Hitung',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            if (_hasil != null) ...[
              const SizedBox(height: 20),
              const Text(
                'HASIL PERHITUNGAN',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.surface2),
                ),
                child: Column(
                  children: _hasil!.entries.map((e) {
                    final isLast = e.key == _hasil!.keys.last;
                    final highlight =
                        e.key == 'Luas Permukaan' || e.key == 'Volume';
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        border: isLast
                            ? null
                            : const Border(
                                bottom: BorderSide(color: AppColors.surface2),
                              ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.key,
                            style: TextStyle(
                              fontSize: 13,
                              color: highlight
                                  ? AppColors.green
                                  : AppColors.textMuted,
                              fontWeight: highlight
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          Text(
                            '${_fmt(e.value)} cm${e.key == 'Volume' ? '³' : '²'}',
                            style: TextStyle(
                              fontSize: highlight ? 16 : 14,
                              fontWeight: highlight
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: highlight
                                  ? AppColors.green
                                  : AppColors.textPrim,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: AppColors.textMuted,
      letterSpacing: 0.8,
    ),
  );

  Widget _buildInput(TextEditingController ctrl, String hint, String suffix) =>
      TextField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(color: AppColors.textPrim, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textMuted),
          suffixText: suffix,
          suffixStyle: const TextStyle(color: AppColors.textMuted),
          filled: true,
          fillColor: AppColors.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.surface2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.green),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      );
}

class _RumusRow extends StatelessWidget {
  final String label;
  final String value;
  const _RumusRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label = ',
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textPrim,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
