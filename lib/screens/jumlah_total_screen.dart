import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class JumlahTotalScreen extends StatefulWidget {
  const JumlahTotalScreen({super.key});

  @override
  State<JumlahTotalScreen> createState() => _JumlahTotalScreenState();
}

class _JumlahTotalScreenState extends State<JumlahTotalScreen> {
  final _ctrl = TextEditingController();
  final List<double> _list = [];
  double _total = 0;
  String _error = '';

  void _tambah() {
    final val = double.tryParse(_ctrl.text.trim());
    if (val == null) {
      setState(() => _error = 'Masukkan angka yang valid!');
      return;
    }
    setState(() {
      _list.add(val);
      _total += val;
      _error = '';
      _ctrl.clear();
    });
  }

  void _hapus(int index) {
    setState(() {
      _total -= _list[index];
      _list.removeAt(index);
    });
  }

  void _reset() {
    setState(() {
      _list.clear();
      _total = 0;
      _error = '';
      _ctrl.clear();
    });
  }

  String _fmt(double n) =>
      n == n.truncateToDouble() ? n.toInt().toString() : n.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bg,
      appBar: AppBar(
        //backgroundColor: AppColors.red.withOpacity(0.1),
        foregroundColor: AppColors.textPrim,
        elevation: 0,
        title: const Text(
          'Jumlah Total Angka',
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
            // Input row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    style: const TextStyle(
                      color: AppColors.textPrim,
                      fontSize: 14,
                    ),
                    onSubmitted: (_) => _tambah(),
                    decoration: InputDecoration(
                      hintText: 'Masukkan angka...',
                      hintStyle: const TextStyle(color: AppColors.textMuted),
                      errorText: _error.isEmpty ? null : _error,
                      errorStyle: const TextStyle(
                        color: AppColors.red,
                        fontSize: 11,
                      ),
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
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _tambah,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.red.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.add_rounded, color: AppColors.red),
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
                border: Border.all(color: AppColors.red.withOpacity(0.3)),
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
                      Text(
                        _fmt(_total),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _reset,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: AppColors.textMuted,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Reset',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DAFTAR ANGKA',
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
              child: _list.isEmpty
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
                            'Belum ada angka',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, i) => Container(
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
                                _fmt(_list[i]),
                                style: const TextStyle(
                                  color: AppColors.textPrim,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _hapus(i),
                              child: const Icon(
                                Icons.close_rounded,
                                color: AppColors.textMuted,
                                size: 18,
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
    );
  }
}
