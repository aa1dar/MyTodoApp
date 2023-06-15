import 'package:flutter/material.dart';
import 'package:todo_app/utils/logger/logger.dart';

class NavigationLogger extends NavigatorObserver {
  static const _tag = 'NAVIGATION';

  bool withName(Route<dynamic>? route) => route?.settings.name != null;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (withName(route)) {
      Logger.info(_tag, 'didPush: ${route.settings.name}');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (withName(route)) {
      Logger.info(_tag, 'didPop: ${route.settings.name}');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (withName(route)) {
      Logger.info(_tag, 'didRemove: ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (withName(newRoute) && withName(oldRoute)) {
      Logger.info(_tag,
          'didReplace: old:${oldRoute!.settings.name}, new:${newRoute!.settings.name}');
    }
  }
}
