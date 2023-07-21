import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/utils/logger/analytics_service.dart';
import 'package:todo_app/utils/logger/analytics_service_interface.dart';

final analyticsServiceProvider = Provider<IAnalyticsService>((ref) {
  final instance = FirebaseAnalytics.instance;
  return AnalyticsService(instance);
});
