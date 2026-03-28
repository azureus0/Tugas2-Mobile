import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HijriahScreen extends StatefulWidget {
  const HijriahScreen({super.key});

  @override
  State<HijriahScreen> createState() => _HijriahScreenState();
}

class _HijriahScreenState extends State<HijriahScreen> {
  DateTime? _selectedDate;
  Map<String, String>? _hasil;

  static const List<String> _bulanHijriah = [
    'Muharram',
    'Safar',
    'Rabiul Awal',
    'Rabiul Akhir',
    'Jumadil Awal',
    'Jumadil Akhir',
    'Rajab',
    "Sya'ban",
    'Ramadan',
    'Syawal',
    "Dzulqa'dah",
    'Dzulhijjah',
  ];

  static const List<String> _hariMasehi = [
    'Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu',
  ];

  static const List<String> _hariArab = [
    'Ahad', 'Itsnain', 'Tsulatsaa', 'Arba\'aa', 'Khomis', 'Jum\'ah', 'Sabt',
  ];

  Map<String, dynamic> _gregorianToHijri(int gy, int gm, int gd) {
    // Julian Day Number
    int a = ((14 - gm) / 12).floor();
    int y = gy + 4800 - a;
    int m = gm + 12 * a - 3;
    double jdn = gd +
        ((153 * m + 2) / 5).floor() +
        365 * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;

    // Konversi JDN ke Hijriah
    int l = (jdn - 1948440 + 10632).toInt();
    int n = ((l - 1) / 10631).floor();
    l = l - 10631 * n + 354;
    int j = ((10985 - l) / 5316).floor() * ((50 * l) ~/ 17719) +
        (l / 5670).floor() * ((43 * l) ~/ 15238);
    l = l -
        ((30 - j) / 15).floor() * ((17719 * j) ~/ 50) -
        (j / 16).floor() * ((15238 * j) ~/ 43) +
        29;
    int hy = 30 * n + j - 30;
    int hm = (24 * l) ~/ 709;
    int hd = l - (709 * hm) ~/ 24;

    return {'tahun': hy, 'bulan': hm, 'hari': hd};
  }

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
      final hijri = _gregorianToHijri(picked.year, picked.month, picked.day);
      final hariIndex = picked.weekday % 7;
      final hariM = _hariMasehi[hariIndex];
      final hariA = _hariArab[hariIndex];
      final namaBulan = _bulanHijriah[(hijri['bulan'] as int) - 1];

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
                    _DetailRow(
                        label: 'Tanggal Masehi',
                        value: _hasil!['Tanggal Masehi']!,
                        isLast: false),
                    _DetailRow(
                        label: 'Hari',
                        value: _hasil!['Hari']!,
                        isLast: false),
                    _DetailRow(
                        label: 'Hari Hijriah',
                        value: _hasil!['Hari Hijriah']!,
                        isLast: false),
                    _DetailRow(
                        label: 'Bulan Hijriah',
                        value: _hasil!['Bulan Hijriah']!,
                        isLast: false),
                    _DetailRow(
                        label: 'Tahun Hijriah',
                        value: _hasil!['Tahun Hijriah']!,
                        isLast: true),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  const _DetailRow(
      {required this.label, required this.value, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.surface2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textMuted)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
