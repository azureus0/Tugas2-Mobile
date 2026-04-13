class StopwatchHelper {
  static String formatTime(int ms) {
    final centisec = ms % 100;
    final sec = (ms ~/ 100) % 60;
    final min = ms ~/ 6000;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}.${centisec.toString().padLeft(2, '0')}';
  }
}
