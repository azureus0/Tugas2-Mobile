class WetonHelper {
  // Nama hari Jawa (Saptawara)
  static const List<String> hariJawa = [
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  // Nama pasaran (Pancawara)
  // Index pasaran: 0=Legi, 1=Pahing, 2=Pon, 3=Wage, 4=Kliwon
  static const List<String> pasaran = [
    'Legi',
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
  ];

  // Referensi: 1 Januari 2000 adalah hari Sabtu (weekday=6) dan Legi (index=0)
  static final DateTime referensi = DateTime(2000, 1, 1);
  static const int referensiPasaranIndex = 0; // Legi

  static String hitungPasaran(DateTime tanggal) {
    final selisihHari = tanggal.difference(referensi).inDays;
    final index = ((referensiPasaranIndex + selisihHari) % 5 + 5) % 5;
    return pasaran[index];
  }
}
