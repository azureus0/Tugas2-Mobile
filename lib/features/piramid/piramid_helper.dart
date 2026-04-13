import 'dart:math';

class PiramidHelper {
  static Map<String, double> hitung(double sisiAlas, double tinggi) {
    final luasAlas = sisiAlas * sisiAlas;
    final apotema = sqrt((tinggi * tinggi) + pow(sisiAlas / 2, 2));
    final luasSelimut = 2 * sisiAlas * apotema;

    return {
      'Luas Alas': luasAlas,
      'Apotema': apotema,
      'Luas Selimut': luasSelimut,
      'Luas Permukaan': luasAlas + luasSelimut,
      'Volume': luasAlas * tinggi / 3,
    };
  }

  static String fmt(double n) =>
      n == n.truncateToDouble() ? n.toInt().toString() : n.toStringAsFixed(2);
}
