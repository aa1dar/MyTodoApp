// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/task_priority.dart';

import 'importance_dto.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'task_dto.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'task_dto.g.dart';

@freezed
class TaskDto with _$TaskDto {
  const factory TaskDto(
      {required String id,
      required String text,
      required ImportanceDto importance,
      @EpochDateTimeConverter() DateTime? deadline,
      required bool done,
      @EpochDateTimeConverter()
      @JsonKey(name: 'created_at')
      DateTime? createdAt,
      @EpochDateTimeConverter()
      @JsonKey(name: 'changed_at')
      DateTime? changedAt,
      @JsonKey(name: 'last_updated_by') String? lastUpdatedBy}) = _TaskDto;

  factory TaskDto.fromJson(Map<String, Object?> json) =>
      _$TaskDtoFromJson(json);
}

extension TaskMapper on TaskDto {
  TaskModel toModel() {
    final priority = TaskPriority.values[importance.index];
    return TaskModel(
        id: id,
        description: text,
        deadline: deadline,
        isCompleted: done,
        priority: priority);
  }
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json, isUtc: true).toLocal();

  @override
  int toJson(DateTime object) => object.toUtc().millisecondsSinceEpoch;
}
