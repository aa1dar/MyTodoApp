import 'package:flutter/material.dart';
import 'package:todo_app/navigation/navigation_routes.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/pages/task_creation_page.dart';
import 'package:todo_app/ui/pages/unknown_page.dart';

import 'navigation_state.dart';

class AppRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? _state;

  @override
  NavigationState get currentConfiguration {
    return _state ?? NavigationState.root();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          name: NavigationRouteName.home,
          child: HomePage(
              onTaskTap: _showTaskEditingPage,
              onTapCreateNewTask: _showTaskCreationPage),
        ),
        if (_state?.isTaskCreationPage == true)
          MaterialPage(
            name: NavigationRouteName.taskCreationPage,
            child: TaskCreationPage(
                onTapBack: _returnToRootPage),
          ),
        if (_state?.isTaskDetailPage == true)
          MaterialPage(
            name: NavigationRouteName.home,
            child: TaskCreationPage(
              onTapBack: _returnToRootPage,
              taskId: _state!.selectedTaskId,
            ),
          ),
        if (_state?.isUnknown == true)
          const MaterialPage(
            child: UnknownPage(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _state = NavigationState.root();

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    _state = configuration;
    notifyListeners();
  }

  void _showTaskEditingPage(String taskId) {
    _state = NavigationState.taskEditing(taskId);
    notifyListeners();
  }

  void _showTaskCreationPage() {
    _state = NavigationState.taskCreation();
    notifyListeners();
  }

  void _returnToRootPage() {
    _state = NavigationState.root();
    notifyListeners();
  }

  void _showUndefinedTaskPage() {
    _state = NavigationState.unknown();
    notifyListeners();
  }
}
