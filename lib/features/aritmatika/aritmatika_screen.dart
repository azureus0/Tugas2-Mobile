import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app_colors.dart';
import 'aritmatika_helper.dart';

class AritmatikaScreen extends StatefulWidget {
  const AritmatikaScreen({super.key});

  @override
  State<AritmatikaScreen> createState() => _AritmatikaScreenState();
}

class _AritmatikaScreenState extends State<AritmatikaScreen> {
  final _aCtrl = TextEditingController();
  final _bCtrl = TextEditingController();
  String _hasil = '';
  String _operasi = '';
  String _aTersimpan = '';
  String _bTersimpan = '';

  @override
  void dispose() {
    _aCtrl.dispose();
    _bCtrl.dispose();
    super.dispose();
  }

  void _resetHasil() {
    if (_hasil.isEmpty && _operasi.isEmpty) return;
    setState(() {
      _hasil = '';
      _operasi = '';
      _aTersimpan = '';
      _bTersimpan = '';
    });
  }

  void _hitung(String op) {
    final a = double.tryParse(_aCtrl.text);
    final b = double.tryParse(_bCtrl.text);
    if (a == null || b == null) {
      setState(() {
        _operasi = '';
        _aTersimpan = '';
        _bTersimpan = '';
        _hasil = 'error';
      });
      return;
    }
    final result = AritmatikaHelper.hitung(a, b, op);
    setState(() {
      _operasi = op;
      _aTersimpan = _aCtrl.text;
      _bTersimpan = _bCtrl.text;
      _hasil = result != null ? AritmatikaHelper.formatResult(result) : 'error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bg,
      appBar: AppBar(
        //backgroundColor: AppColors.orange.withOpacity(0.1),
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Penjumlahan & Pengurangan',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Material(
            color: AppColors.surface2,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _InputCard(
                label: 'ANGKA PERTAMA',
                controller: _aCtrl,
                color: AppColors.orange,
                onChanged: _resetHasil,
              ),
              const SizedBox(height: 12),
              _InputCard(
                label: 'ANGKA KEDUA',
                controller: _bCtrl,
                color: AppColors.orange,
                onChanged: _resetHasil,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _OpButton(
                      label: 'Jumlahkan',
                      icon: Icons.add_rounded,
                      color: const Color(0xFF4ADE80),
                      onTap: () => _hitung('+'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OpButton(
                      label: 'Kurangkan',
                      icon: Icons.remove_rounded,
                      color: AppColors.red,
                      onTap: () => _hitung('-'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_hasil.isNotEmpty)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.orange.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _hasil == 'error'
                            ? 'Masukkan angka yang valid!'
                            : '${AritmatikaHelper.formatNum(_aTersimpan)} $_operasi ${AritmatikaHelper.formatNum(_bTersimpan)} = $_hasil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _hasil == 'error' ? 14 : 22,
                          fontWeight: FontWeight.w700,
                          color: _hasil == 'error'
                              ? AppColors.red
                              : AppColors.orange,
                        ),
                      ),
                      if (_hasil != 'error') ...[
                        const SizedBox(height: 6),
                        Text(
                          'Hasil',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Color color;
  final VoidCallback onChanged;
  const _InputCard({
    required this.label,
    required this.controller,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: (_) => onChanged(),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(15),
            TextInputFormatter.withFunction((oldValue, newValue) {
              final text = newValue.text;
              final isValid = RegExp(r'^-?\d*\.?\d*$').hasMatch(text);
              return isValid ? newValue : oldValue;
            }),
          ],
          style: const TextStyle(color: AppColors.textPrim, fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Masukkan angka',
            hintStyle: const TextStyle(color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.surface2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _OpButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _OpButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
