// jumlah_total_helper.dart

class JumlahTotalHelper {
  static const int _maxDigitsPerNumber = 15;

  static JumlahTotalResult extractNumbers(String text) {
    final matches = RegExp(
      r'(?<!\d)-?(?:\d{1,3}(?:[.,]\d{3})+|\d+)(?:[.,]\d+)?(?!\d)',
    ).allMatches(text);

    final numbers = <double>[];
    final ignoredNumbers = <IgnoredNumber>[];

    for (final match in matches) {
      final raw = match.group(0)!;
      final parsed = _parseNumber(raw);

      if (parsed == null) {
        // tetap tampilkan tapi sebagai ignored
        ignoredNumbers.add(IgnoredNumber(
          raw: raw,
          preview: raw.length > 6 ? '${raw.substring(0, 6)}...' : raw,
        ));
        continue;
      }

      numbers.add(parsed);
    }

    return JumlahTotalResult(
      numbers: numbers,
      ignoredNumbers: ignoredNumbers,
    );
  }

  static double? sum(List<double> values) {
    final result = values.fold(0.0, (total, value) => total + value);
    if (result.isInfinite || result.isNaN) return null;
    if (result.abs() > 999999999999999) return null;
    return result;
  }

  static String fmt(double n) =>
      n == n.truncateToDouble() ? n.toInt().toString() : n.toStringAsFixed(2);

  static double? _parseNumber(String raw) {
    var value = raw.trim();
    final digitCount = value.replaceAll(RegExp(r'[^0-9]'), '').length;

    if (digitCount > _maxDigitsPerNumber) return null;

    final isDotThousands = RegExp(
      r'^-?\d{1,3}(?:\.\d{3})+(?:,\d+)?$',
    ).hasMatch(value);

    if (isDotThousands) {
      value = value.replaceAll('.', '').replaceAll(',', '.');
    } else if (value.contains(',')) {
      value = value.replaceAll(',', '.');
    }

    return double.tryParse(value);
  }
}

class JumlahTotalResult {
  final List<double> numbers;
  final List<IgnoredNumber> ignoredNumbers;

  const JumlahTotalResult({
    required this.numbers,
    required this.ignoredNumbers,
  });
}

class IgnoredNumber {
  final String raw;
  final String preview; // misal "123456..."

  const IgnoredNumber({required this.raw, required this.preview});
}