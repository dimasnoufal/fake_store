import 'dart:developer' as developer;

class Logger {
  static void printInfo(String text) {
    developer.log('\x1B[33m$text\x1B[0m');
  }

  static void printX(String text) {
    developer.log('\x1B[31m$text\x1B[0m');
  }

  static void printY(String text) {
    developer.log('\x1B[32m$text\x1B[0m');
  }
}
