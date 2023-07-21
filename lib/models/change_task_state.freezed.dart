// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChangeTaskState {
  TaskModel get task => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isUndefinedIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangeTaskStateCopyWith<ChangeTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeTaskStateCopyWith<$Res> {
  factory $ChangeTaskStateCopyWith(
          ChangeTaskState value, $Res Function(ChangeTaskState) then) =
      _$ChangeTaskStateCopyWithImpl<$Res, ChangeTaskState>;
  @useResult
  $Res call({TaskModel task, bool isLoading, bool isUndefinedIndex});
}

/// @nodoc
class _$ChangeTaskStateCopyWithImpl<$Res, $Val extends ChangeTaskState>
    implements $ChangeTaskStateCopyWith<$Res> {
  _$ChangeTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? isLoading = null,
    Object? isUndefinedIndex = null,
  }) {
    return _then(_value.copyWith(
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUndefinedIndex: null == isUndefinedIndex
          ? _value.isUndefinedIndex
          : isUndefinedIndex // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChangeTaskStateCopyWith<$Res>
    implements $ChangeTaskStateCopyWith<$Res> {
  factory _$$_ChangeTaskStateCopyWith(
          _$_ChangeTaskState value, $Res Function(_$_ChangeTaskState) then) =
      __$$_ChangeTaskStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TaskModel task, bool isLoading, bool isUndefinedIndex});
}

/// @nodoc
class __$$_ChangeTaskStateCopyWithImpl<$Res>
    extends _$ChangeTaskStateCopyWithImpl<$Res, _$_ChangeTaskState>
    implements _$$_ChangeTaskStateCopyWith<$Res> {
  __$$_ChangeTaskStateCopyWithImpl(
      _$_ChangeTaskState _value, $Res Function(_$_ChangeTaskState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? isLoading = null,
    Object? isUndefinedIndex = null,
  }) {
    return _then(_$_ChangeTaskState(
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUndefinedIndex: null == isUndefinedIndex
          ? _value.isUndefinedIndex
          : isUndefinedIndex // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChangeTaskState implements _ChangeTaskState {
  _$_ChangeTaskState(
      {this.task = const TaskModel(id: '', description: ''),
      this.isLoading = false,
      this.isUndefinedIndex = false});

  @override
  @JsonKey()
  final TaskModel task;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUndefinedIndex;

  @override
  String toString() {
    return 'ChangeTaskState(task: $task, isLoading: $isLoading, isUndefinedIndex: $isUndefinedIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeTaskState &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUndefinedIndex, isUndefinedIndex) ||
                other.isUndefinedIndex == isUndefinedIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, task, isLoading, isUndefinedIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeTaskStateCopyWith<_$_ChangeTaskState> get copyWith =>
      __$$_ChangeTaskStateCopyWithImpl<_$_ChangeTaskState>(this, _$identity);
}

abstract class _ChangeTaskState implements ChangeTaskState {
  factory _ChangeTaskState(
      {final TaskModel task,
      final bool isLoading,
      final bool isUndefinedIndex}) = _$_ChangeTaskState;

  @override
  TaskModel get task;
  @override
  bool get isLoading;
  @override
  bool get isUndefinedIndex;
  @override
  @JsonKey(ignore: true)
  _$$_ChangeTaskStateCopyWith<_$_ChangeTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}
