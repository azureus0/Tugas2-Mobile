class BilanganHelper {
  static bool isPrima(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  static bool isGanjil(int n) => n % 2 != 0;
}
