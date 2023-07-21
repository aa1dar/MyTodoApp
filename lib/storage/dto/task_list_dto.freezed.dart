// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskListDto _$TaskListDtoFromJson(Map<String, dynamic> json) {
  return _TaskListDto.fromJson(json);
}

/// @nodoc
mixin _$TaskListDto {
  List<TaskDto> get list => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskListDtoCopyWith<TaskListDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskListDtoCopyWith<$Res> {
  factory $TaskListDtoCopyWith(
          TaskListDto value, $Res Function(TaskListDto) then) =
      _$TaskListDtoCopyWithImpl<$Res, TaskListDto>;
  @useResult
  $Res call({List<TaskDto> list, int revision});
}

/// @nodoc
class _$TaskListDtoCopyWithImpl<$Res, $Val extends TaskListDto>
    implements $TaskListDtoCopyWith<$Res> {
  _$TaskListDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TaskDto>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskListDtoCopyWith<$Res>
    implements $TaskListDtoCopyWith<$Res> {
  factory _$$_TaskListDtoCopyWith(
          _$_TaskListDto value, $Res Function(_$_TaskListDto) then) =
      __$$_TaskListDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TaskDto> list, int revision});
}

/// @nodoc
class __$$_TaskListDtoCopyWithImpl<$Res>
    extends _$TaskListDtoCopyWithImpl<$Res, _$_TaskListDto>
    implements _$$_TaskListDtoCopyWith<$Res> {
  __$$_TaskListDtoCopyWithImpl(
      _$_TaskListDto _value, $Res Function(_$_TaskListDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? revision = null,
  }) {
    return _then(_$_TaskListDto(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TaskDto>,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskListDto implements _TaskListDto {
  const _$_TaskListDto(
      {required final List<TaskDto> list, required this.revision})
      : _list = list;

  factory _$_TaskListDto.fromJson(Map<String, dynamic> json) =>
      _$$_TaskListDtoFromJson(json);

  final List<TaskDto> _list;
  @override
  List<TaskDto> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final int revision;

  @override
  String toString() {
    return 'TaskListDto(list: $list, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskListDto &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskListDtoCopyWith<_$_TaskListDto> get copyWith =>
      __$$_TaskListDtoCopyWithImpl<_$_TaskListDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskListDtoToJson(
      this,
    );
  }
}

abstract class _TaskListDto implements TaskListDto {
  const factory _TaskListDto(
      {required final List<TaskDto> list,
      required final int revision}) = _$_TaskListDto;

  factory _TaskListDto.fromJson(Map<String, dynamic> json) =
      _$_TaskListDto.fromJson;

  @override
  List<TaskDto> get list;
  @override
  int get revision;
  @override
  @JsonKey(ignore: true)
  _$$_TaskListDtoCopyWith<_$_TaskListDto> get copyWith =>
      throw _privateConstructorUsedError;
}
