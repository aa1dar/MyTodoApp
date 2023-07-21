// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskDto _$$_TaskDtoFromJson(Map<String, dynamic> json) => _$_TaskDto(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: $enumDecode(_$ImportanceDtoEnumMap, json['importance']),
      deadline: _$JsonConverterFromJson<int, DateTime>(
          json['deadline'], const EpochDateTimeConverter().fromJson),
      done: json['done'] as bool,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['created_at'], const EpochDateTimeConverter().fromJson),
      changedAt: _$JsonConverterFromJson<int, DateTime>(
          json['changed_at'], const EpochDateTimeConverter().fromJson),
      lastUpdatedBy: json['last_updated_by'] as String?,
    );

Map<String, dynamic> _$$_TaskDtoToJson(_$_TaskDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceDtoEnumMap[instance.importance]!,
      'deadline': _$JsonConverterToJson<int, DateTime>(
          instance.deadline, const EpochDateTimeConverter().toJson),
      'done': instance.done,
      'created_at': _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const EpochDateTimeConverter().toJson),
      'changed_at': _$JsonConverterToJson<int, DateTime>(
          instance.changedAt, const EpochDateTimeConverter().toJson),
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceDtoEnumMap = {
  ImportanceDto.low: 'low',
  ImportanceDto.basic: 'basic',
  ImportanceDto.important: 'important',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
