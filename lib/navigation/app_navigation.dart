abstract class AppNavigation {
  void showTaskEditingPage(String taskId);

  void showTaskCreationPage();

  void returnToRootPage();

  void showUndefinedTaskPage();

  void onPop();
}
