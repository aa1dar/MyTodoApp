import 'package:flutter/material.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/pages/task_creation_page.dart';

abstract class NavigationRouteName {
  static const home = '/';
  static const taskCreationPage = '/task_creation_page';
}

abstract class NavigationRoutesBuilder {
  static final routes = {
    NavigationRouteName.home: (BuildContext context) => const HomePage(),
    NavigationRouteName.taskCreationPage: (BuildContext context) =>
        const TaskCreationPage()
  };
}
