import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_task_list.dart';
import 'package:todo_app/providers/task_filter_provider.dart';
import 'package:todo_app/providers/task_list_provider.dart';

final filteredTaskListProvider = Provider<TodoTaskList>((ref) {
  final filter = ref.watch(filterStateProvider);
  final tasks = ref.watch(taskListProvider);

  switch (filter) {
    case FilterType.none:
      return tasks;
    case FilterType.uncompleted:
      return TodoTaskList(
          data: tasks.data.where((task) => !task.isCompleted).toList());
  }
});
