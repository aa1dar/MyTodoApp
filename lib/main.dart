import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/utils/logger/logger.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  _initFirebaseCrashlytics();
  runApp(ProviderScope(child: MyApp()));
}

Future<void> _initFirebase() async {
  Logger.info('FIREBASE', 'Firebase initialization was started');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _initFirebaseCrashlytics() {
  FlutterError.onError = (errorDetails) {
    Logger.error('CRASHLYTICS', 'Caught an error by FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    Logger.error('CRASHLYTICS', 'Caught an error by PlatformDispatcher');
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
