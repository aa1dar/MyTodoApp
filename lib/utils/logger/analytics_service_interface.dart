abstract class IAnalyticsService {
  Future<void> logEvent(String name, Map<String, String> parameters);

  Future<void> logNavigation(String screenName,
      {bool didPush = false, bool didPop = false});

  Future<void> logAction(String actionName, Map<String, String> parameters);

  Future<void> logCreationOfTask(String taskId);

  Future<void> logDeletionOfTask(String taskId);

  Future<void> logCompletionOfTask(String taskId, [bool? isComplete]);

  Future<void> setCurrentScreen(String screenName);

  // Future<void> logAction(String actionName,
  //     {Map<String, String>? additionalParameters});
}
