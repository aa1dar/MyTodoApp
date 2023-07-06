import 'package:flutter/material.dart';
import 'package:todo_app/navigation/navigation_routes.dart';

import 'navigation_state.dart';

class AppRouteInformationParser extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    if (location == null) {
      return NavigationState.unknown();
    }

    final uri = Uri.parse(location);

    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    if (uri.pathSegments.length == 2) {
      final itemId = uri.pathSegments[1];

      if (uri.pathSegments[0] == NavigationRouteName.taskEditingPage) {
        return NavigationState.taskEditing(itemId);
      }

      return NavigationState.unknown();
    }

    if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];
      if (path == NavigationRouteName.taskCreationPage) {
        return NavigationState.taskCreation();
      }

      return NavigationState.unknown();
    }

    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isTaskCreationPage) {
      return const RouteInformation(
          location: '/${NavigationRouteName.taskCreationPage}');
    }

    if (configuration.isTaskDetailPage) {
      return RouteInformation(
          location:
              '/${NavigationRouteName.taskEditingPage}/${configuration.selectedTaskId}');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/');
  }
}
