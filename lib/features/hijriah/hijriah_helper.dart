import 'package:hijri/hijri_calendar.dart';

class HijriahHelper {
  static const List<String> bulanHijriah = [
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

  static const List<String> hariMasehi = [
    'Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu',
  ];

  static const List<String> hariArab = [
    'Ahad', 'Itsnain', 'Tsulatsaa', "Arba'aa", 'Khomis', "Jum'ah", 'Sabt',
  ];

  static Map<String, dynamic> gregorianToHijri(int gy, int gm, int gd) {
    final date = DateTime(gy, gm, gd);

    final hijri = HijriCalendar.fromDate(date);

    return {
      'tahun': hijri.hYear,
      'bulan': hijri.hMonth,
      'hari': hijri.hDay,
      'namaBulan': bulanHijriah[hijri.hMonth - 1],
    };
  }
}