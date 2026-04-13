import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../widgets/detail_row.dart';
import 'hijriah_helper.dart';

class HijriahScreen extends StatefulWidget {
  const HijriahScreen({super.key});

  @override
  State<HijriahScreen> createState() => _HijriahScreenState();
}

class _HijriahScreenState extends State<HijriahScreen> {
  DateTime? _selectedDate;
  Map<String, String>? _hasil;

  void _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.orange,
            surface: AppColors.surface,
            onSurface: AppColors.textPrim,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final hijri = HijriahHelper.gregorianToHijri(picked.year, picked.month, picked.day);
      final hariIndex = picked.weekday % 7;
      final hariM = HijriahHelper.hariMasehi[hariIndex];
      final hariA = HijriahHelper.hariArab[hariIndex];
      final namaBulan = HijriahHelper.bulanHijriah[(hijri['bulan'] as int) - 1];

      setState(() {
        _selectedDate = picked;
        _hasil = {
          'Tanggal Masehi':
              '${picked.day}/${picked.month}/${picked.year}',
          'Hari': '$hariM ($hariA)',
          'Tanggal Hijriah':
              '${hijri['hari']} $namaBulan ${hijri['tahun']} H',
          'Hari Hijriah': '${hijri['hari']}',
          'Bulan Hijriah': namaBulan,
          'Tahun Hijriah': '${hijri['tahun']} H',
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
          'Konversi Hijriah',
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
                color: AppColors.orange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.orange.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: const [
                  Icon(Icons.mosque_rounded,
                      color: AppColors.orange, size: 28),
                  SizedBox(height: 8),
                  Text(
                    'Konversi Masehi ke Hijriah',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrim,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Konversi tanggal kalender Masehi ke kalender Hijriah (Islam)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'PILIH TANGGAL MASEHI',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: _pilihTanggal,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedDate != null
                        ? AppColors.orange.withValues(alpha: 0.5)
                        : AppColors.surface2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_rounded,
                        color: _selectedDate != null
                            ? AppColors.orange
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
                  color: AppColors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: AppColors.orange.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  'Konversi ke Hijriah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.orange,
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

              // Highlight Hijriah
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: AppColors.orange.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'TANGGAL HIJRIAH',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _hasil!['Tanggal Hijriah']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.surface2),
                ),
                child: Column(
                  children: [
                    DetailRow(
                        label: 'Tanggal Masehi',
                        value: _hasil!['Tanggal Masehi']!,
                        isLast: false,
                        flexible: true),
                    DetailRow(
                        label: 'Hari',
                        value: _hasil!['Hari']!,
                        isLast: false,
                        flexible: true),
                    DetailRow(
                        label: 'Hari Hijriah',
                        value: _hasil!['Hari Hijriah']!,
                        isLast: false,
                        flexible: true),
                    DetailRow(
                        label: 'Bulan Hijriah',
                        value: _hasil!['Bulan Hijriah']!,
                        isLast: false,
                        flexible: true),
                    DetailRow(
                        label: 'Tahun Hijriah',
                        value: _hasil!['Tahun Hijriah']!,
                        isLast: true,
                        flexible: true),
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
