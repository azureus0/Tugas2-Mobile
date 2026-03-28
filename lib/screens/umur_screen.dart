import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class UmurScreen extends StatefulWidget {
  const UmurScreen({super.key});

  @override
  State<UmurScreen> createState() => _UmurScreenState();
}

class _UmurScreenState extends State<UmurScreen> {
  DateTime? _tanggalLahir;
  TimeOfDay? _jamLahir;
  Map<String, dynamic>? _hasil;

  bool _isKabisat(int tahun) {
    return (tahun % 4 == 0 && tahun % 100 != 0) || (tahun % 400 == 0);
  }

  void _hitung() {
    if (_tanggalLahir == null) return;

    final now = DateTime.now();
    final lahir = DateTime(
      _tanggalLahir!.year,
      _tanggalLahir!.month,
      _tanggalLahir!.day,
      _jamLahir?.hour ?? 0,
      _jamLahir?.minute ?? 0,
    );

    if (lahir.isAfter(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tanggal lahir tidak boleh di masa depan!',
              style: TextStyle(color: AppColors.red)),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    int tahun = now.year - lahir.year;
    int bulan = now.month - lahir.month;
    int hari = now.day - lahir.day;
    int jam = now.hour - lahir.hour;
    int menit = now.minute - lahir.minute;

    if (menit < 0) {
      menit += 60;
      jam--;
    }
    if (jam < 0) {
      jam += 24;
      hari--;
    }
    if (hari < 0) {
      final bulanLalu = DateTime(now.year, now.month - 1, 1);
      final hariDalamBulanLalu =
          DateTime(bulanLalu.year, bulanLalu.month + 1, 0).day;
      hari += hariDalamBulanLalu;
      bulan--;
    }
    if (bulan < 0) {
      bulan += 12;
      tahun--;
    }

    final selisihTotal = now.difference(lahir);
    final totalHari = selisihTotal.inDays;
    final totalJam = selisihTotal.inHours;
    final totalMenit = selisihTotal.inMinutes;

    setState(() {
      _hasil = {
        'tahun': tahun,
        'bulan': bulan,
        'hari': hari,
        'jam': jam,
        'menit': menit,
        'totalHari': totalHari,
        'totalJam': totalJam,
        'totalMenit': totalMenit,
        'kabisat': _isKabisat(_tanggalLahir!.year),
        'tahunLahir': _tanggalLahir!.year,
      };
    });
  }

  void _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.purple,
            surface: AppColors.surface,
            onSurface: AppColors.textPrim,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _tanggalLahir = picked);
  }

  void _pilihJam() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.purple,
            surface: AppColors.surface,
            onSurface: AppColors.textPrim,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _jamLahir = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Kalkulator Umur',
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
                color: AppColors.purple.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.purple.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: const [
                  Icon(Icons.cake_rounded, color: AppColors.purple, size: 28),
                  SizedBox(height: 8),
                  Text(
                    'Kalkulator Tanggal Lahir',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrim,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Hitung umur lengkap & cek tahun kabisat',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tanggal lahir
            const Text(
              'TANGGAL LAHIR',
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
                    color: _tanggalLahir != null
                        ? AppColors.purple.withValues(alpha: 0.5)
                        : AppColors.surface2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_rounded,
                        color: _tanggalLahir != null
                            ? AppColors.purple
                            : AppColors.textMuted,
                        size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _tanggalLahir != null
                          ? '${_tanggalLahir!.day}/${_tanggalLahir!.month}/${_tanggalLahir!.year}'
                          : 'Pilih tanggal lahir',
                      style: TextStyle(
                        color: _tanggalLahir != null
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
            const SizedBox(height: 12),

            // Jam lahir
            const Text(
              'JAM LAHIR',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pilihJam,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _jamLahir != null
                        ? AppColors.purple.withValues(alpha: 0.5)
                        : AppColors.surface2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        color: _jamLahir != null
                            ? AppColors.purple
                            : AppColors.textMuted,
                        size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _jamLahir != null
                          ? '${_jamLahir!.hour.toString().padLeft(2, '0')}:${_jamLahir!.minute.toString().padLeft(2, '0')}'
                          : 'Pilih jam lahir (opsional)',
                      style: TextStyle(
                        color: _jamLahir != null
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
              onTap: _tanggalLahir != null ? _hitung : null,
              child: Opacity(
                opacity: _tanggalLahir != null ? 1.0 : 0.4,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
                  ),
                  child: const Text(
                    'Hitung Umur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.purple,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            if (_hasil != null) ...[
              const SizedBox(height: 24),

              // Umur utama
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'UMUR KAMU',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _UmurChip(
                            value: '${_hasil!['tahun']}', label: 'Tahun'),
                        const SizedBox(width: 8),
                        _UmurChip(
                            value: '${_hasil!['bulan']}', label: 'Bulan'),
                        const SizedBox(width: 8),
                        _UmurChip(value: '${_hasil!['hari']}', label: 'Hari'),
                        const SizedBox(width: 8),
                        _UmurChip(value: '${_hasil!['jam']}', label: 'Jam'),
                        const SizedBox(width: 8),
                        _UmurChip(
                            value: '${_hasil!['menit']}', label: 'Menit'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Total
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.surface2),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                      label: 'Total Hari',
                      value: '${_hasil!['totalHari']} hari',
                      isLast: false,
                    ),
                    _DetailRow(
                      label: 'Total Jam',
                      value: '${_hasil!['totalJam']} jam',
                      isLast: false,
                    ),
                    _DetailRow(
                      label: 'Total Menit',
                      value: '${_hasil!['totalMenit']} menit',
                      isLast: false,
                    ),
                    _DetailRow(
                      label: 'Tahun ${_hasil!['tahunLahir']}',
                      value: _hasil!['kabisat']
                          ? '✓ Tahun Kabisat'
                          : '✗ Bukan Kabisat',
                      isLast: true,
                      valueColor: _hasil!['kabisat']
                          ? AppColors.green
                          : AppColors.textMuted,
                    ),
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

class _UmurChip extends StatelessWidget {
  final String value;
  final String label;
  const _UmurChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.purple,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  final Color? valueColor;
  const _DetailRow({
    required this.label,
    required this.value,
    required this.isLast,
    this.valueColor,
  });

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
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textPrim,
            ),
          ),
        ],
      ),
    );
  }
}
