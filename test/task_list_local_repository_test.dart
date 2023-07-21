import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/storage/dto/importance_dto.dart';
import 'package:todo_app/storage/dto/task_dto.dart';
import 'package:todo_app/storage/local/task_list_local_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'task_list_local_repository_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late TaskListLocalRepository localRepository;
  final MockDatabase mockDatabase = MockDatabase();

  setUp(() {
    localRepository = TaskListLocalRepository(mockDatabase);
  });

  const task = TaskDto(
      id: '123', text: '123', importance: ImportanceDto.basic, done: true);

  test('with saving the task in the local database, also saving the action',
      () async {
    // arrange
    when(mockDatabase.insert(tableTaskList, any)).thenAnswer((_) async {
      return 0;
    });

    when(mockDatabase.insert(tableTaskActionHistory, any))
        .thenAnswer((realInvocation) async {
      return 0;
    });
    // act
    await localRepository.insertTask(task);
    // assert
    verify(mockDatabase.insert(tableTaskActionHistory, any));
  });
}
