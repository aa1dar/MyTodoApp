import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/storage/dto/importance_dto.dart';
import 'package:todo_app/storage/dto/task_dto.dart';
import 'package:todo_app/storage/local/revision_local_repository.dart';
import 'package:todo_app/storage/local/task_list_local_repository.dart';
import 'package:todo_app/storage/main_repository.dart';
import 'package:todo_app/storage/network/task_list_network_repository.dart';

import 'main_repostitory_test.mocks.dart';

@GenerateMocks([
  TaskListLocalRepository,
  RevisionLocalRepository,
  TaskListNetworkRepository
])
void main() {
  late MainRepository mainRepository;
  final localRepository = MockTaskListLocalRepository();
  final revisionRepository = MockRevisionLocalRepository();
  final networkRepository = MockTaskListNetworkRepository();

  setUp(() {
    mainRepository =
        MainRepository(localRepository, networkRepository, revisionRepository);
  });

  final task = TaskDto(
      id: "123123123",
      text: 'blablabla',
      importance: ImportanceDto.important,
      done: true,
      deadline: DateTime.parse('1970-01-20 16:03:30.709'),
      createdAt: DateTime.parse('1970-01-20 16:03:30.709'),
      changedAt: DateTime.parse('1970-01-20 16:03:30.709'),
      lastUpdatedBy: '111');

  test(
      'When data cannot be received from the server, only Local mode is enabled',
      () async {
    // arrange
    when(networkRepository.fetchTaskList())
        .thenThrow(DioException(requestOptions: RequestOptions()));
    when(localRepository.getAllTasks()).thenAnswer((realInvocation) async {
      return [task];
    });
    // act
    final result = await mainRepository.fetchTasks();
    // assert
    expect(result, equals([task.toModel()]));
    expect(mainRepository.localSavingOnly, true);
  });

  test(
      'When data cannot be received from the server, only Local mode is enabled',
      () async {
    // arrange
    when(networkRepository.fetchTaskList())
        .thenThrow(DioException(requestOptions: RequestOptions()));
    when(localRepository.getAllTasks()).thenAnswer((realInvocation) async {
      return [task];
    });
    // act
    final result = await mainRepository.fetchTasks();
    // assert
    expect(result, equals([task.toModel()]));
    expect(mainRepository.localSavingOnly, true);
  });
}
