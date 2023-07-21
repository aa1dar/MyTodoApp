import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_app/storage/dto/importance_dto.dart';
import 'package:todo_app/storage/dto/task_dto.dart';
import 'package:todo_app/storage/dto/task_list_dto.dart';
import 'package:todo_app/storage/network/api_service.dart';
import 'package:todo_app/storage/network/task_list_network_repository.dart';

void main() {
  late ApiService apiService;
  late Dio dioClient;
  late DioAdapter dioAdapter;
  late TaskListNetworkRepository networkRepository;
  const baseUrl = 'http://example.com';

  setUp(() {
    dioClient = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(dio: dioClient);
    apiService = ApiService(dioClient);
    networkRepository = TaskListNetworkRepository(apiService);
  });

  const jsonString = """
{
  "status": "ok",
  "list": [
    {
      "id": "123123123",
      "text": "blablabla",
      "importance": "important",
      "deadline": 1688610709,
      "done": true,
      "created_at": 1688610709,
      "changed_at": 1688610709,
      "last_updated_by": "111"
    }
  ],
  "revision": 1
}""";

  final tasks = TaskListDto(list: [
    TaskDto(
        id: "123123123",
        text: 'blablabla',
        importance: ImportanceDto.important,
        done: true,
        deadline: DateTime.fromMillisecondsSinceEpoch(1688610709, isUtc: true)
            .toLocal(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(1688610709, isUtc: true)
            .toLocal(),
        changedAt: DateTime.fromMillisecondsSinceEpoch(1688610709, isUtc: true)
            .toLocal(),
        lastUpdatedBy: '111')
  ], revision: 1);

  test('should return a TaskListDto with success when status code is 200',
      () async {
    // arrange
    dioAdapter.onGet(
      '/list',
      (server) => server.reply(
        200,
        jsonDecode(jsonString),
        delay: const Duration(seconds: 1),
      ),
    );
    // act
    final result = await networkRepository.fetchTaskList();
    // assert
    expect(result, equals(tasks));
  });
}
