import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/task_priority.dart';
import 'package:todo_app/models/todo_task_list.dart';
import 'package:todo_app/utils/constants/provider_names.dart';
import 'package:uuid/uuid.dart';

const _uuidV4 = Uuid();

final taskProvider = Provider<TaskModel>((ref) {
  return TaskModel(id: '', description: '');
});

final taskListProvider = StateNotifierProvider<TaskList, TodoTaskList>((ref) {
  return TaskList(TodoTaskList(data: []));
}, name: ProviderNames.taskListStateNotifier);

class TaskList extends StateNotifier<TodoTaskList> {
  TaskList(TodoTaskList initialList) : super(initialList);

  void add(String description,
      {TaskPriority priority = TaskPriority.normal, DateTime? deadline}) {
    state = TodoTaskList(data: [
      ...state.data,
      TaskModel(
          id: const Uuid().v4(),
          description: description,
          priority: priority,
          deadline: deadline)
    ]);
  }

  void change(String id, TaskModel newModel) {
    state = TodoTaskList(data: [
      for (final todo in state.data)
        if (todo.id == id) newModel else todo
    ]);
  }

  void delete(String id) {
    state = TodoTaskList(data: [
      for (final todo in state.data)
        if (todo.id != id) todo
    ]);
  }

  void toogle(String id) {
    state = TodoTaskList(data: [
      for (final todo in state.data)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo
    ]);
  }
}
