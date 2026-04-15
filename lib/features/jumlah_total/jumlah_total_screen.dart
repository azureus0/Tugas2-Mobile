// jumlah_total_screen.dart

import 'package:flutter/material.dart';
import '../../app_colors.dart';
import 'jumlah_total_helper.dart';

class JumlahTotalScreen extends StatefulWidget {
  const JumlahTotalScreen({super.key});

  @override
  State<JumlahTotalScreen> createState() => _JumlahTotalScreenState();
}

class _JumlahTotalScreenState extends State<JumlahTotalScreen> {
  final _ctrl = TextEditingController();
  final List<double> _list = [];
  final List<IgnoredNumber> _ignoredList = [];
  double? _total;
  bool _totalOverflow = false;
  String _error = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _deteksi() {
    final result = JumlahTotalHelper.extractNumbers(_ctrl.text);

    if (result.numbers.isEmpty && result.ignoredNumbers.isEmpty) {
      setState(() {
        _list.clear();
        _ignoredList.clear();
        _total = null;
        _totalOverflow = false;
        _error = 'Tidak ada angka yang ditemukan di dalam teks.';
      });
      return;
    }

    final total = JumlahTotalHelper.sum(result.numbers);

    setState(() {
      _list
        ..clear()
        ..addAll(result.numbers);
      _ignoredList
        ..clear()
        ..addAll(result.ignoredNumbers);
      _total = total;
      _totalOverflow = total == null;
      _error = '';
    });
  }

  void _reset() {
    setState(() {
      _list.clear();
      _ignoredList.clear();
      _total = null;
      _totalOverflow = false;
      _error = '';
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasIgnored = _ignoredList.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Deteksi & Jumlah Angka',
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
              'TEMPEL TEKS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrl,
              minLines: 5,
              maxLines: 7,
              style: const TextStyle(color: AppColors.textPrim, fontSize: 14),
              decoration: InputDecoration(
                hintText:
                    'Contoh: budi makan 89 donat harga 5.000 total 15.000',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                errorText: _error.isEmpty ? null : _error,
                errorStyle: const TextStyle(color: AppColors.red, fontSize: 11),
                filled: true,
                fillColor: AppColors.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _error.isNotEmpty
                        ? AppColors.red
                        : AppColors.surface2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.red),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            ),

            // Info angka diabaikan
            if (hasIgnored) ...[
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.orange.withOpacity(0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: AppColors.orange, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${_ignoredList.length} angka terlalu panjang diabaikan: '
                        '${_ignoredList.map((e) => e.preview).join(', ')}',
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _deteksi,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: AppColors.red.withOpacity(0.3)),
                      ),
                      child: const Text(
                        'Deteksi Angka',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _reset,
                  child: Container(
                    width: 52,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Total card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _totalOverflow
                      ? AppColors.orange.withOpacity(0.3)
                      : AppColors.red.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOTAL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _totalOverflow
                          ? const Text(
                              'Terlalu besar!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.orange,
                              ),
                            )
                          : Text(
                              _total != null
                                  ? JumlahTotalHelper.fmt(_total!)
                                  : '0',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColors.red,
                              ),
                            ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'TERDETEKSI',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_list.length} angka',
                        style: const TextStyle(
                          color: AppColors.textPrim,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (hasIgnored) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${_ignoredList.length} diabaikan',
                          style: const TextStyle(
                            color: AppColors.orange,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ANGKA YANG DITEMUKAN',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  '${_list.length} angka',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: _list.isEmpty && _ignoredList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.functions_rounded,
                            color: AppColors.textMuted.withOpacity(0.3),
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Belum ada angka yang terdeteksi',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: [
                        // Angka valid
                        ..._list.asMap().entries.map((entry) {
                          final i = entry.key;
                          final val = entry.value;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.surface2),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.red.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                        color: AppColors.red,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    JumlahTotalHelper.fmt(val),
                                    style: const TextStyle(
                                      color: AppColors.textPrim,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  'angka ke-${i + 1}',
                                  style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        // Angka diabaikan
                        ..._ignoredList.map((ignored) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.orange.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.orange.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.orange.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.warning_amber_rounded,
                                        color: AppColors.orange,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      ignored.preview,
                                      style: const TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'terlalu panjang',
                                    style: TextStyle(
                                      color: AppColors.orange,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}