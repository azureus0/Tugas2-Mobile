import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BilanganScreen extends StatefulWidget {
  const BilanganScreen({super.key});

  @override
  State<BilanganScreen> createState() => _BilanganScreenState();
}

class _BilanganScreenState extends State<BilanganScreen> {
  final _ctrl = TextEditingController();
  int? _angka;
  bool _sudahCek = false;

  bool _isPrima(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cek() {
    final n = int.tryParse(_ctrl.text.trim());
    setState(() {
      _angka = n;
      _sudahCek = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isGanjil = _angka != null && _angka! % 2 != 0;
    final isPrima = _angka != null && _isPrima(_angka!);

    return Scaffold(
      //backgroundColor: AppColors.bg,
      appBar: AppBar(
        //backgroundColor: AppColors.purple.withOpacity(0.1),
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Ganjil/Genap & Prima',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'MASUKKAN BILANGAN',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _ctrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrim, fontSize: 15),
              onSubmitted: (_) => _cek(),
              decoration: InputDecoration(
                hintText: 'Contoh: 17',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surface2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.purple),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: _cek,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.purple.withOpacity(0.3)),
                ),
                child: const Text(
                  'Cek Bilangan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.purple,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_sudahCek) ...[
              if (_angka == null)
                _ResultCard(
                  color: AppColors.red,
                  title: 'Input tidak valid',
                  subtitle: 'Masukkan bilangan bulat',
                )
              else ...[
                _ResultCard(
                  color: AppColors.purple,
                  title: isGanjil ? 'Bilangan GANJIL' : 'Bilangan GENAP',
                  subtitle: '$_angka ${isGanjil ? "tidak" : ""} habis dibagi 2',
                ),
                const SizedBox(height: 12),
                _ResultCard(
                  color: isPrima ? AppColors.teal : AppColors.textMuted,
                  title: isPrima ? 'Bilangan PRIMA' : 'Bukan Bilangan Prima',
                  subtitle: isPrima
                      ? '$_angka hanya habis dibagi 1 dan $_angka'
                      : '$_angka memiliki faktor selain 1 dan dirinya sendiri',
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  const _ResultCard({
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
