class AritmatikaHelper {
  static double? hitung(double a, double b, String op) {
    if (op == '+') return a + b;
    if (op == '-') return a - b;
    return null;
  }

  static String formatNum(String raw) {
    final n = double.tryParse(raw);
    if (n == null) return raw;
    return _formatDouble(n);
  }

  static String formatResult(double result) {
    return _formatDouble(result);
  }

  static String _formatDouble(double value) {
    if (value == 0) return '0';
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }

    final text = value.toStringAsFixed(12);
    return text
        .replaceFirst(RegExp(r'\.?0+$'), '');
  }
}
