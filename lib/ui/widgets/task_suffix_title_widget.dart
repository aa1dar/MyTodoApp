import 'package:flutter/material.dart';
import 'package:todo_app/models/task_priority.dart';

class TaskSuffixTitleWidget extends StatelessWidget {
  const TaskSuffixTitleWidget({super.key, required this.priority});
  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (priority) {
      case TaskPriority.high:
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(
              height: 24,
              width: 24,
            ),
            Positioned(
              right: -4.5,
              child:
                  Icon(Icons.priority_high_rounded, color: colorScheme.error),
            ),
            Positioned(
              left: -4.5,
              child:
                  Icon(Icons.priority_high_rounded, color: colorScheme.error),
            ),
          ],
        );
      case TaskPriority.low:
        return Icon(Icons.arrow_downward_rounded,
            color: colorScheme.tertiaryContainer);
      case TaskPriority.normal:
        return const SizedBox.shrink();
    }
  }
}
