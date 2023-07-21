import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_app/storage/network/api_service.dart';

void main() {
  late ApiService apiService;
  late Dio dioClient;
  late DioAdapter dioAdapter;
  const baseUrl = 'http://example.com';

  setUp(() {
    dioClient = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(dio: dioClient);
    apiService = ApiService(dioClient);
  });

  test(
      'should throw an ArgumentError when the server did not return status \'ok\'',
      () async {
    // arrange
    dioAdapter.onGet(
      '/list',
      (server) => server.reply(
        200,
        {'status': 'Not ok'},
        delay: const Duration(seconds: 1),
      ),
    );
    // act
    final call = apiService.fetchTaskList();
    // assert
    expect(() => call, throwsA(isA<ArgumentError>()));
  });

  test('should throw an DioError when the server did not return 200', () async {
    // arrange
    dioAdapter.onGet(
      '/list',
      (server) => server.reply(
        400,
        {'status': 'Not ok'},
        delay: const Duration(seconds: 1),
      ),
    );
    // act
    final call = apiService.fetchTaskList();
    // assert
    expect(() => call, throwsA(isA<DioException>()));
  });
}
