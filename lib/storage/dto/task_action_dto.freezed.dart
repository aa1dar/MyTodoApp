// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_action_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskActionDto _$TaskActionDtoFromJson(Map<String, dynamic> json) {
  return _TaskActionDto.fromJson(json);
}

/// @nodoc
mixin _$TaskActionDto {
  int? get id => throw _privateConstructorUsedError;
  @ActionTypeConverter()
  ActionType get action => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_id')
  String? get taskId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskActionDtoCopyWith<TaskActionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskActionDtoCopyWith<$Res> {
  factory $TaskActionDtoCopyWith(
          TaskActionDto value, $Res Function(TaskActionDto) then) =
      _$TaskActionDtoCopyWithImpl<$Res, TaskActionDto>;
  @useResult
  $Res call(
      {int? id,
      @ActionTypeConverter() ActionType action,
      DateTime timestamp,
      @JsonKey(name: 'task_id') String? taskId});
}

/// @nodoc
class _$TaskActionDtoCopyWithImpl<$Res, $Val extends TaskActionDto>
    implements $TaskActionDtoCopyWith<$Res> {
  _$TaskActionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? action = null,
    Object? timestamp = null,
    Object? taskId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ActionType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskActionDtoCopyWith<$Res>
    implements $TaskActionDtoCopyWith<$Res> {
  factory _$$_TaskActionDtoCopyWith(
          _$_TaskActionDto value, $Res Function(_$_TaskActionDto) then) =
      __$$_TaskActionDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @ActionTypeConverter() ActionType action,
      DateTime timestamp,
      @JsonKey(name: 'task_id') String? taskId});
}

/// @nodoc
class __$$_TaskActionDtoCopyWithImpl<$Res>
    extends _$TaskActionDtoCopyWithImpl<$Res, _$_TaskActionDto>
    implements _$$_TaskActionDtoCopyWith<$Res> {
  __$$_TaskActionDtoCopyWithImpl(
      _$_TaskActionDto _value, $Res Function(_$_TaskActionDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? action = null,
    Object? timestamp = null,
    Object? taskId = freezed,
  }) {
    return _then(_$_TaskActionDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ActionType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskActionDto implements _TaskActionDto {
  const _$_TaskActionDto(
      {this.id,
      @ActionTypeConverter() required this.action,
      required this.timestamp,
      @JsonKey(name: 'task_id') this.taskId});

  factory _$_TaskActionDto.fromJson(Map<String, dynamic> json) =>
      _$$_TaskActionDtoFromJson(json);

  @override
  final int? id;
  @override
  @ActionTypeConverter()
  final ActionType action;
  @override
  final DateTime timestamp;
  @override
  @JsonKey(name: 'task_id')
  final String? taskId;

  @override
  String toString() {
    return 'TaskActionDto(id: $id, action: $action, timestamp: $timestamp, taskId: $taskId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskActionDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, timestamp, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskActionDtoCopyWith<_$_TaskActionDto> get copyWith =>
      __$$_TaskActionDtoCopyWithImpl<_$_TaskActionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskActionDtoToJson(
      this,
    );
  }
}

abstract class _TaskActionDto implements TaskActionDto {
  const factory _TaskActionDto(
      {final int? id,
      @ActionTypeConverter() required final ActionType action,
      required final DateTime timestamp,
      @JsonKey(name: 'task_id') final String? taskId}) = _$_TaskActionDto;

  factory _TaskActionDto.fromJson(Map<String, dynamic> json) =
      _$_TaskActionDto.fromJson;

  @override
  int? get id;
  @override
  @ActionTypeConverter()
  ActionType get action;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(name: 'task_id')
  String? get taskId;
  @override
  @JsonKey(ignore: true)
  _$$_TaskActionDtoCopyWith<_$_TaskActionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
