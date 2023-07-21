import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  const CustomFab({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<CustomFab> createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController scaleController;
  late final Animation<double> scaleAnimation;

  final _animationDuration = const Duration(milliseconds: 300);
  final _reverseAnimationDuration = const Duration(milliseconds: 150);
  final _delay = const Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
        vsync: this,
        duration: _animationDuration,
        reverseDuration: _reverseAnimationDuration);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          onTap();
        }
      },
      child: Stack(alignment: Alignment.center, children: [
        AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) => Transform.scale(
              scale: scaleAnimation.value,
              child: const FloatingActionButton(
                onPressed: null,
              )),
        ),
        const Icon(
          Icons.add,
        ),
      ]),
    );
  }

  void onTap() {
    scaleController.forward();
    Future.delayed(_animationDuration + _delay, widget.onTap?.call())
        .then((_) => Future.delayed(_delay, () => scaleController.reverse()));
  }
}
