import 'package:flutter/material.dart';
import 'package:todo_app/env/env.dart';

class BannerWrapper extends StatelessWidget {
  final Widget child;
  const BannerWrapper({super.key, required this.child});

  final isProd = Env.appFlavor == 'prod';

  @override
  Widget build(BuildContext context) {
    if (isProd) {
      return child;
    }
    return Banner(
        location: BannerLocation.topStart, message: 'DEV', child: child);
  }
}
