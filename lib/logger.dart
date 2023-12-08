// ignore_for_file: avoid_print

class Logger {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => print(' ** $text. isError: [$isError]'));
  }
}
