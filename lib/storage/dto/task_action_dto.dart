import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_action_dto.freezed.dart';
part 'task_action_dto.g.dart';

@freezed
class TaskActionDto with _$TaskActionDto {
  const factory TaskActionDto(
      {int? id,
      @ActionTypeConverter() required ActionType action,
      required DateTime timestamp,
      @JsonKey(name: 'task_id') String? taskId}) = _TaskActionDto;

  factory TaskActionDto.fromJson(Map<String, Object?> json) =>
      _$TaskActionDtoFromJson(json);
}

enum ActionType { delete, create, change }

class ActionTypeConverter implements JsonConverter<ActionType, int> {
  const ActionTypeConverter();

  @override
  ActionType fromJson(int json) => ActionType.values[json];

  @override
  int toJson(ActionType object) => object.index;
}
