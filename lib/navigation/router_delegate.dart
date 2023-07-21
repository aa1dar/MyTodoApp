import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/navigation/fade_transition_page.dart';
import 'package:todo_app/navigation/navigation_routes.dart';
import 'package:todo_app/providers/analytics_service_provider.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/pages/task_creation_page.dart';
import 'package:todo_app/ui/pages/unknown_page.dart';
import 'package:todo_app/utils/logger/logger.dart';

import 'app_navigation.dart';
import 'navigation_state.dart';

class AppRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState>
    implements AppNavigation {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final Ref ref;

  static const _tag = 'NAVIGATION';

  AppRouterDelegate(
    this.ref,
  ) : navigatorKey = GlobalKey<NavigatorState>() {
    ref.read(analyticsServiceProvider).logNavigation(NavigationRouteName.home);
  }

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
        const MaterialPage(
          name: NavigationRouteName.home,
          child: HomePage(),
        ),
        if (_state?.isTaskCreationPage == true)
          const FadeTransitionPage(
            name: NavigationRouteName.taskCreationPage,
            child: TaskCreationPage(),
          ),
        if (_state?.isTaskDetailPage == true)
          MaterialPage(
            name: NavigationRouteName.home,
            child: TaskCreationPage(
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

        onPop();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    _state = configuration;
    notifyListeners();
  }

  @override
  void showTaskEditingPage(String taskId) {
    Logger.info(_tag, 'Task editing page was opened (taskId: $taskId)');
    ref
        .read(analyticsServiceProvider)
        .logNavigation(NavigationRouteName.taskEditingPage, didPush: true);

    _state = NavigationState.taskEditing(taskId);
    notifyListeners();
  }

  @override
  void showTaskCreationPage() {
    Logger.info(_tag, 'Task creation page was opened');
    ref
        .read(analyticsServiceProvider)
        .logNavigation(NavigationRouteName.taskCreationPage, didPush: true);

    _state = NavigationState.taskCreation();
    notifyListeners();
  }

  @override
  void returnToRootPage() {
    Logger.info(_tag, 'The user returned to the root page');
    ref
        .read(analyticsServiceProvider)
        .logNavigation(NavigationRouteName.home, didPop: true);

    _state = NavigationState.root();
    notifyListeners();
  }

  @override
  void showUndefinedTaskPage() {
    Logger.info(_tag, 'The unknow page was opened');

    ref
        .read(analyticsServiceProvider)
        .logNavigation(NavigationRouteName.unknownPage, didPush: true);

    _state = NavigationState.unknown();
    notifyListeners();
  }

  @override
  void onPop() => returnToRootPage();
}
