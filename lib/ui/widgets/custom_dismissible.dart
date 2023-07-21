import 'package:flutter/material.dart';
import 'package:todo_app/ui/pages/home_page.dart';

class CustomDismissible extends StatefulWidget {
  final Widget child;
  final Widget? background;
  final Widget? secondaryBackground;
  final ConfirmDismissCallback? confirmDismiss;
  final VoidCallback? onResize;
  final DismissDirectionCallback? onDismissed;
  final DismissUpdateCallback? onUpdate;
  final String stringKey;

  const CustomDismissible({
    super.key,
    required this.stringKey,
    required this.child,
    this.background,
    this.secondaryBackground,
    this.confirmDismiss,
    this.onResize,
    this.onDismissed,
    this.onUpdate,
  });

  @override
  State<CustomDismissible> createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  static const _homePageSumOfPadding = 2 * HomePage.horizontalPadding;

  double progress = 0;
  double length = 0;

  double calculateOffset() {
    final offsetSize = progress * length;
    if (offsetSize > 72) {
      return offsetSize - 48;
    }

    return 24;
  }

  @override
  void didChangeDependencies() {
    setState(() {
      length = MediaQuery.of(context).size.width - _homePageSumOfPadding;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.stringKey),
      confirmDismiss: widget.confirmDismiss,
      onDismissed: widget.onDismissed,
      onUpdate: (details) {
        setState(() {
          progress = details.progress;
        });
      },
      secondaryBackground: SizedBox(
        child: Container(
          color: Theme.of(context).colorScheme.error,
          padding: EdgeInsets.only(right: calculateOffset()),
          alignment: AlignmentDirectional.centerEnd,
          child: const Icon(Icons.delete),
        ),
      ),
      background: Container(
          color: Colors.green,
          padding: EdgeInsets.only(left: calculateOffset()),
          alignment: AlignmentDirectional.centerStart,
          child: const Icon(Icons.check)),
      child: widget.child,
    );
  }
}
