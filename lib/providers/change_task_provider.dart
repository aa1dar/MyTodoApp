import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/change_task_state.dart';
import 'package:todo_app/providers/loading_state_provider.dart';
import 'package:todo_app/providers/task_list_provider.dart';

final changeTaskListProvider = StateNotifierProvider.autoDispose
    .family<ChangeTaskListStateNotifier, ChangeTaskState, String?>(
        (ref, taskId) => ChangeTaskListStateNotifier(ref: ref, taskId: taskId));

class ChangeTaskListStateNotifier extends StateNotifier<ChangeTaskState> {
  final Ref ref;
  final String? taskId;

  ChangeTaskListStateNotifier({required this.ref, required this.taskId})
      : super(ChangeTaskState()) {
    if (taskId != null) {
      fetchTask(taskId!);
    } else {
      state = ChangeTaskState();
    }
  }

  void fetchTask(String id) {
    state = state.copyWith(isLoading: true);
    final isLoading = ref.watch(isLoadingTasksProvider);
    if (isLoading) {
      return;
    }

    final taskListSnap = ref.watch(taskListProvider).data;
    final indexOfTask = taskListSnap.indexWhere((element) => element.id == id);
    if (indexOfTask == -1) {
      state = ChangeTaskState(isLoading: false, isUndefinedIndex: true);
    } else {
      state =
          ChangeTaskState(task: taskListSnap[indexOfTask], isLoading: false);
    }
  }
}
