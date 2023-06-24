// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskListDto _$$_TaskListDtoFromJson(Map<String, dynamic> json) =>
    _$_TaskListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$$_TaskListDtoToJson(_$_TaskListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'revision': instance.revision,
    };
