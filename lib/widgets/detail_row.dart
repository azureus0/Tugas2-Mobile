import 'package:flutter/material.dart';
import '../app_colors.dart';

/// Widget baris detail yang dipakai bersama oleh weton, hijriah, dan umur screen.
/// - [flexible] : bungkus value dalam Flexible (untuk teks panjang, default false)
/// - [valueColor] : warna custom untuk teks value (default AppColors.textPrim)
class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  final Color? valueColor;
  final bool flexible;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.isLast,
    this.valueColor,
    this.flexible = false,
  });

  @override
  Widget build(BuildContext context) {
    final valueWidget = Text(
      value,
      textAlign: flexible ? TextAlign.right : null,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: valueColor ?? AppColors.textPrim,
      ),
    );

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
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          flexible ? Flexible(child: valueWidget) : valueWidget,
        ],
      ),
    );
  }
}
