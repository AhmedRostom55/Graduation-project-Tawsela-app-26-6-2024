import 'package:flutter/foundation.dart';

class AppLogger {
  static log(Object? message) {
    if (kDebugMode) {
      print(message);
    }
  }
}