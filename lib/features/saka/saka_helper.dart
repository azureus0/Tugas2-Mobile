import 'dart:convert';

import 'package:flutter/services.dart';

class SakaHelper {
  static Map<String, dynamic>? _lookup;

  static Future<void> ensureLoaded() async {
    if (_lookup != null) return;

    final raw = await rootBundle.loadString('assets/data/balinese_lookup.json');
    _lookup = jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>?> fromGregorian(DateTime date) async {
    await ensureLoaded();
    final key = _keyFromDate(date);
    final value = _lookup?[key];
    if (value is! Map) return null;

    final result = Map<String, dynamic>.from(value as Map);
    result['formattedSaka'] = formatSaka(result);
    return result;
  }

  static String formatSaka(Map<String, dynamic> data) {
    return '${data['sasihDayInfo']} ${data['sasihDay']}, ${data['sasih']}, Saka ${data['saka']}';
  }

  static String _keyFromDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
