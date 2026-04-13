import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../widgets/detail_row.dart';
import 'weton_helper.dart';

class WetonScreen extends StatefulWidget {
  const WetonScreen({super.key});

  @override
  State<WetonScreen> createState() => _WetonScreenState();
}

class _WetonScreenState extends State<WetonScreen> {
  DateTime? _selectedDate;
  Map<String, String>? _hasil;

  void _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.teal,
              surface: AppColors.surface,
              onSurface: AppColors.textPrim,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final hariMasehi = WetonHelper.hariJawa[picked.weekday % 7];
      final pasaran = WetonHelper.hitungPasaran(picked);
      setState(() {
        _selectedDate = picked;
        _hasil = {
          'Tanggal': '${picked.day}/${picked.month}/${picked.year}',
          'Hari': hariMasehi,
          'Pasaran': pasaran,
          'Weton': '$hariMasehi $pasaran',
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Konversi Weton',
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
            // Info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.teal.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: const [
                  Icon(Icons.calendar_today_rounded,
                      color: AppColors.teal, size: 28),
                  SizedBox(height: 8),
                  Text(
                    'Konversi Hari ke Weton Jawa',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrim,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pasaran: Legi · Pahing · Pon · Wage · Kliwon',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'PILIH TANGGAL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),

            // Date picker button
            GestureDetector(
              onTap: _pilihTanggal,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedDate != null
                        ? AppColors.teal.withValues(alpha: 0.5)
                        : AppColors.surface2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_rounded,
                        color: _selectedDate != null
                            ? AppColors.teal
                            : AppColors.textMuted,
                        size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Ketuk untuk memilih tanggal',
                      style: TextStyle(
                        color: _selectedDate != null
                            ? AppColors.textPrim
                            : AppColors.textMuted,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.textMuted, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: _pilihTanggal,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  'Konversi Weton',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.teal,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            if (_hasil != null) ...[
              const SizedBox(height: 24),
              const Text(
                'HASIL KONVERSI',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),

              // Weton highlight card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'WETON',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _hasil!['Weton']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Detail cards
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.surface2),
                ),
                child: Column(
                  children: [
                    DetailRow(
                        label: 'Tanggal', value: _hasil!['Tanggal']!, isLast: false),
                    DetailRow(
                        label: 'Hari Masehi', value: _hasil!['Hari']!, isLast: false),
                    DetailRow(
                        label: 'Pasaran', value: _hasil!['Pasaran']!, isLast: true),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
