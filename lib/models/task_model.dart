import 'package:todo_app/models/task_priority.dart';
class TaskModel {
  final String id;
  final String description;
  final bool isCompleted;
  final TaskPriority priority;
  final DateTime? deadline;

  TaskModel({
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.priority = TaskPriority.normal,
    this.deadline,
  });


  TaskModel copyWith({
    String? id,
    String? description,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? deadline,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, description: $description, isCompleted: $isCompleted, priority: $priority, deadline: $deadline)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.priority == priority &&
        other.deadline == deadline;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        priority.hashCode ^
        deadline.hashCode;
  }
}
