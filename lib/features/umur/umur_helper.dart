class UmurHelper {
  static bool isKabisat(int tahun) {
    return (tahun % 4 == 0 && tahun % 100 != 0) || (tahun % 400 == 0);
  }

  static Map<String, dynamic> hitungUmur(DateTime lahir, DateTime now) {
    int tahun = now.year - lahir.year;
    int bulan = now.month - lahir.month;
    int hari = now.day - lahir.day;
    int jam = now.hour - lahir.hour;
    int menit = now.minute - lahir.minute;

    if (menit < 0) { menit += 60; jam--; }
    if (jam < 0) { jam += 24; hari--; }
    if (hari < 0) {
      final bulanLalu = DateTime(now.year, now.month - 1, 1);
      final hariDalamBulanLalu =
          DateTime(bulanLalu.year, bulanLalu.month + 1, 0).day;
      hari += hariDalamBulanLalu;
      bulan--;
    }
    if (bulan < 0) { bulan += 12; tahun--; }

    final selisihTotal = now.difference(lahir);

    return {
      'tahun': tahun,
      'bulan': bulan,
      'hari': hari,
      'jam': jam,
      'menit': menit,
      'totalHari': selisihTotal.inDays,
      'totalJam': selisihTotal.inHours,
      'totalMenit': selisihTotal.inMinutes,
      'kabisat': isKabisat(lahir.year),
      'tahunLahir': lahir.year,
    };
  }
}
