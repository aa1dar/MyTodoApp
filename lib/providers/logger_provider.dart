import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/todo_task_list.dart';
import 'package:todo_app/utils/constants/provider_names.dart';
import 'package:todo_app/utils/logger/logger.dart';

class LoggerProvider extends ProviderObserver {
  static const _tag = 'PROVIDER';

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // Only when debug mode is enabled
    // Because comparing 2 states is an expensive operation
    if (!kDebugMode) return;

    if (provider.name == ProviderNames.taskListStateNotifier) {
      final prevValue = previousValue as TodoTaskList;
      final nValue = newValue as TodoTaskList;

      if (prevValue.data.length < nValue.data.length) {
        Logger.d(_tag, 'Task added: ${nValue.data.last}');
      }
      if (prevValue.data.length > nValue.data.length) {
        TaskModel? deletedTask;
        for (var i = 0; i < nValue.data.length; i++) {
          if (nValue.data[i].id != prevValue.data[i].id) {
            deletedTask = prevValue.data[i];
            break;
          }
        }
        deletedTask ??= previousValue.data.last;
        Logger.d(_tag, 'Task deleted: $deletedTask');
      }
    }
  }
}
