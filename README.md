# Tugas 2 - Pemrograman Mobile

Aplikasi Flutter multi-fitur untuk tugas mata kuliah Pemrograman Mobile. Project ini memakai struktur berbasis `features`, memiliki halaman login, menu utama, dan beberapa fitur utilitas/perhitungan seperti aritmatika, bilangan, hijriah, stopwatch, piramid, weton, umur, jumlah total, dan kalender Saka Bali.

## Setup Awal (Wajib sebelum `flutter run`)

### 1. Generate data lookup Saka Bali

Pastikan Node.js sudah terinstall, lalu jalankan:

```bash
node tool/generate_balinese_lookup.js
```

Script ini akan membuat file `assets/data/balinese_lookup.json` yang dibutuhkan fitur Kalender Saka Bali.

### 2. Install dependencies Flutter

```bash
flutter pub get
```

### 3. Jalankan aplikasi

```bash
flutter run
```

Login memakai data user yang disimpan di `lib/user_model.dart`.
#### Contoh:

Username: abc

Password: 123

## Struktur Project

```text
lib/
+-- main.dart
+-- app_colors.dart
+-- user_model.dart
+-- widgets/
¦   +-- detail_row.dart
+-- features/
    +-- auth/
    +-- home/
    +-- data_kelompok/
    +-- aritmatika/
    +-- bilangan/
    +-- hijriah/
    +-- jumlah_total/
    +-- piramid/
    +-- saka/
    +-- stopwatch/
    +-- umur/
    +-- weton/
    +-- placeholder/
```

Setiap fitur umumnya dipisah menjadi:
- `*_screen.dart` untuk tampilan/UI
- `*_helper.dart` untuk logika bantu/perhitungan

## Fitur Utama

- `Login`
  Validasi username dan password sebelum masuk ke menu utama.
- `Data Kelompok`
  Menampilkan data anggota kelompok.
- `Aritmatika`
  Penjumlahan dan pengurangan dua angka dengan input terfilter.
- `Bilangan`
  Mengecek bilangan ganjil/genap dan prima untuk input bilangan bulat.
- `Hijriah`
  Konversi tanggal Masehi ke kalender Hijriah.
- `Jumlah Total`
  Menjumlahkan data angka secara akumulatif.
- `Stopwatch`
  Stopwatch dengan start, stop, reset, dan lap.
- `Piramid`
  Menghitung luas alas, apotema, luas selimut, luas permukaan, dan volume piramid persegi.
- `Umur`
  Menghitung umur dari tanggal lahir.
- `Weton`
  Menampilkan weton berdasarkan tanggal yang dipilih.
- `Kalender Saka Bali`
  Menampilkan tanggal Saka Bali dari tanggal Masehi.

## Kalender Saka Bali

Fitur Saka Bali memakai lookup data yang digenerate dari library:
- `peradnya/balinese-date-js-lib`

File lookup disimpan di:
- `assets/data/balinese_lookup.json`

Script generator disimpan di:
- `tool/generate_balinese_lookup.js`

Helper Saka membaca data lookup tersebut melalui asset bundle di:
- `lib/features/saka/saka_helper.dart`

## Catatan

- Project ini sudah memakai Material 3.
- Warna aplikasi dipusatkan di `lib/app_colors.dart`.
- Beberapa fitur input sudah diberi formatter dan pembatasan input agar lebih aman saat dipakai.
