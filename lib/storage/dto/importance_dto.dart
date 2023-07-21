import 'package:todo_app/models/task_priority.dart';

enum ImportanceDto { low, basic, important }

extension ImportanceDtoMapper on ImportanceDto {
  static fromModel(TaskPriority priority) {
    return ImportanceDto.values[priority.index];
  }
}
