// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_action_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskActionDto _$$_TaskActionDtoFromJson(Map<String, dynamic> json) =>
    _$_TaskActionDto(
      id: json['id'] as int?,
      action: const ActionTypeConverter().fromJson(json['action'] as int),
      timestamp: DateTime.parse(json['timestamp'] as String),
      taskId: json['task_id'] as String?,
    );

Map<String, dynamic> _$$_TaskActionDtoToJson(_$_TaskActionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': const ActionTypeConverter().toJson(instance.action),
      'timestamp': instance.timestamp.toIso8601String(),
      'task_id': instance.taskId,
    };
