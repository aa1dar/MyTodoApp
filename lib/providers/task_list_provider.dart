import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/task_priority.dart';
import 'package:todo_app/models/todo_task_list.dart';
import 'package:todo_app/providers/loading_state_provider.dart';
import 'package:todo_app/providers/task_repository_provider.dart';
import 'package:todo_app/utils/constants/provider_names.dart';


final taskProvider = Provider<TaskModel>((ref) {
  return const TaskModel(id: '', description: '');
});

final taskListProvider = StateNotifierProvider<TaskList, TodoTaskList>((ref) {
  return TaskList(ref: ref);
}, name: ProviderNames.taskListStateNotifier);

class TaskList extends StateNotifier<TodoTaskList> {
  TaskList({required this.ref}) : super(TodoTaskList(data: [])) {
    fetchTasks(ref: ref);
  }
  final Ref ref;

  void fetchTasks({required Ref ref}) async {
    await ref.read(taskRepositoryProvider).fetchTasks().then((tasks) {
      state = TodoTaskList(data: tasks);

      ref.read(isLoadingTasksProvider.notifier).state = false;
    });
  }

  void add(String description,
      {TaskPriority priority = TaskPriority.normal, DateTime? deadline}) async {
    ref.read(isLoadingTasksProvider.notifier).state = true;
    final newModel = await ref.read(taskRepositoryProvider).addTask(TaskModel(
        id: '-',
        description: description,
        priority: priority,
        deadline: deadline));

    if (newModel != null) {
      state = TodoTaskList(data: [...state.data, newModel]);
    }

    ref.read(isLoadingTasksProvider.notifier).state = false;
  }

  void change(String id, TaskModel newModel) async {
    ref.read(isLoadingTasksProvider.notifier).state = true;
    final changedModel =
        await ref.read(taskRepositoryProvider).changeTask(id, newModel);

    state = TodoTaskList(data: [
      for (final todo in state.data)
        if (todo.id == id) changedModel else todo
    ]);
    ref.read(isLoadingTasksProvider.notifier).state = false;
  }

  void delete(String id) {
    ref.read(taskRepositoryProvider).delete(id);
    state = TodoTaskList(data: [
      for (final todo in state.data)
        if (todo.id != id) todo
    ]);
  }

  void toogle(String id) {
    ref.read(taskRepositoryProvider).toogle(id);
    state = TodoTaskList(data: [
      for (final todo in state.data)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo
    ]);
  }
}
