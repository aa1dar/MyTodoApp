import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:todo_app/utils/logger/analytics_service_interface.dart';
import 'package:todo_app/utils/logger/logger.dart';

class AnalyticsService extends IAnalyticsService {
  static const _tag = 'ANALYTICS';
  final FirebaseAnalytics instance;

  AnalyticsService(this.instance);

  @override
  Future<void> logEvent(String name, Map<String, String> parameters) {
    return instance.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setCurrentScreen(String screenName) {
    return instance.setCurrentScreen(screenName: screenName);
  }

  @override
  Future<void> logNavigation(String screenName,
      {bool didPush = false, bool didPop = false}) async {
    const tag = 'navigation';
    final Map<String, String> parameters = {
      'screen_name': screenName.toString()
    };

    if (didPop ^ didPush) {
      parameters.addEntries([
        MapEntry('did_pop', didPop.toString()),
        MapEntry('did_push', didPush.toString())
      ]);
    }

    try {
      await setCurrentScreen(screenName);
      await logEvent(tag, parameters);
      Logger.d(_tag, 'Navigation event successfully sent');
    } catch (e) {
      Logger.error(_tag, 'Navigation event is not sent');
    }
  }

  @override
  Future<void> logCompletionOfTask(String taskId, [bool? isComplete]) {
    final encryptedId = getEncryptedTaskId(taskId);
    isComplete ??= false;
    return logAction('task_completion_event',
        {'task_id': encryptedId, 'is_complete': isComplete.toString()});
  }

  @override
  Future<void> logCreationOfTask(String taskId) {
    final encryptedId = getEncryptedTaskId(taskId);
    return logAction('task_creation_event', {'task_id': encryptedId});
  }

  @override
  Future<void> logDeletionOfTask(String taskId) {
    final encryptedId = getEncryptedTaskId(taskId);
    return logAction('task_deletion_event', {'task_id': encryptedId});
  }

  @override
  Future<void> logAction(
      String actionName, Map<String, String> parameters) async {
    try {
      await logEvent(actionName, parameters);
      Logger.d(_tag, 'Action event successfully sent');
    } catch (e) {
      Logger.error(_tag, 'Action event is not sent');
    }
  }

  String getEncryptedTaskId(String taskId) {
    final length = taskId.length;
    return taskId.substring(length - 4, length).padLeft(7, '*');
  }
}
