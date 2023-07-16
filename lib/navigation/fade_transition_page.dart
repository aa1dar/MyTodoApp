import 'package:flutter/material.dart';

class FadeTransitionPage extends Page {
  final Widget child;

  const FadeTransitionPage({required this.child, super.key, super.name});

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
            opacity: animation,
            child: child);
      },
    );
  }
}
