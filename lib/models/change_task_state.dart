import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/task_model.dart';

part 'change_task_state.freezed.dart';

@freezed
class ChangeTaskState with _$ChangeTaskState {
  factory ChangeTaskState({
    @Default(TaskModel(id: '', description: '')) TaskModel task,
    @Default(false) bool isLoading,
    @Default(false) bool isUndefinedIndex,
  }) = _ChangeTaskState;
}
