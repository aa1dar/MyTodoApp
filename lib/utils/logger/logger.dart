import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class Logger {
  static void info(String tag, String msg) {
    debugPrint('\x1B[33m[$tag]: $msg\x1B[0m');
  }

  static void error(String tag, String msg) {
    debugPrint('\x1B[31m[$tag]: $msg\x1B[0m');
  }

  static void success(String tag, String msg) {
    debugPrint('\x1B[32m[$tag]: $msg\x1B[0m');
  }

  // NOTE: Only for debugging
  static void d(String tag, String msg) {
    if (kDebugMode) developer.log('[$tag]: $msg');
  }
}
