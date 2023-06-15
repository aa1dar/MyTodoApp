import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/task_list_provider.dart';

final countOfTaskProvider = Provider<int>((ref) {
  return ref
      .watch(taskListProvider)
      .data
      .where((todo) => todo.isCompleted)
      .length;
});
