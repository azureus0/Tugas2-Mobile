# Tugas 2 - Pemrograman Mobile

Aplikasi Flutter multi-menu dengan tema dark, dibuat sebagai tugas kelompok mata kuliah Pemrograman Mobile.

---

## 🚀 Cara Menjalankan

```bash
flutter pub get
flutter run
```

Login menggunakan username dan password yang terdaftar di `models/user_model.dart`.

---

## 📁 Struktur File

```
lib/
├── main.dart
├── models/
│   └── user_model.dart
├── theme/
│   └── app_colors.dart
└── screens/
    ├── login_screen.dart
    ├── home_screen.dart
    ├── data_kelompok_screen.dart
    ├── aritmatika_screen.dart
    ├── bilangan_screen.dart
    ├── jumlah_total_screen.dart
    ├── stopwatch_screen.dart
    └── piramid_screen.dart
```

---

## 📄 Penjelasan File

### `main.dart`
Entry point aplikasi. Mengatur tema global (dark theme) dan menentukan halaman pertama yang ditampilkan yaitu `LoginScreen`.

---

### `models/user_model.dart`
Mendefinisikan class `User` dengan atribut `username` dan `password`. Berisi `userList`, yaitu daftar user yang terdaftar dan diizinkan untuk login ke aplikasi.

---

### `theme/app_colors.dart`
Menyimpan semua konstanta warna yang digunakan di seluruh aplikasi. Dibuat terpusat di sini agar warna mudah diubah tanpa harus mengedit satu per satu di tiap file.

---

### `screens/login_screen.dart`
Halaman login. User memasukkan username dan password, lalu divalidasi terhadap `userList` di `user_model.dart`. Jika cocok, user diarahkan ke `HomeScreen`. Jika salah, muncul pesan error.

---

### `screens/home_screen.dart`
Halaman utama setelah login. Menampilkan grid 6 menu yang masing-masing mengarah ke halaman fitur yang berbeda. Terdapat tombol logout untuk kembali ke halaman login.

---

### `screens/data_kelompok_screen.dart`
Menampilkan informasi anggota kelompok berupa nama, NIM, dan peran masing-masing anggota dalam bentuk list card.

---

### `screens/aritmatika_screen.dart`
Halaman kalkulator sederhana. User memasukkan dua angka, lalu memilih operasi penjumlahan (+) atau pengurangan (−). Hasil ditampilkan di bawah tombol operasi.

---

### `screens/bilangan_screen.dart`
Halaman pengecekan bilangan. User memasukkan sebuah bilangan bulat, lalu aplikasi menampilkan apakah bilangan tersebut **ganjil atau genap**, dan apakah termasuk **bilangan prima** atau bukan.

---

### `screens/jumlah_total_screen.dart`
Halaman akumulasi angka. User dapat memasukkan angka satu per satu, dan aplikasi akan menjumlahkan semuanya secara kumulatif. Terdapat fitur hapus per item dan reset semua.

---

### `screens/stopwatch_screen.dart`
Halaman stopwatch dengan tampilan timer format `MM:SS.ms`. Memiliki tombol **Start**, **Stop**, **Reset**, dan **Lap** untuk mencatat waktu putaran.

---

### `screens/piramid_screen.dart`
Halaman kalkulator piramid persegi. User memasukkan panjang sisi alas dan tinggi piramid, lalu aplikasi menghitung dan menampilkan **luas alas**, **apotema**, **luas selimut**, **luas permukaan**, dan **volume**.

---
