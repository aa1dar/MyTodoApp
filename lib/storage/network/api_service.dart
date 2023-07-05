import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo_app/env/env.dart';
import 'package:todo_app/utils/logger/logger.dart';

class ApiService {
  static const _tag = 'API_SERVICE';
  static final _baseUrl = Env.apiBaseUrl;

  Dio? _dio;

  Dio get _dioGetter {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          baseUrl: _baseUrl,
          headers: {'Content-Type': 'application/json'}));
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${Env.apiServiceToken}';
          handler.next(options);
        },
      ));
      _dio!.interceptors.add(LogInterceptor(
          logPrint: (object) => Logger.d(_tag, object.toString())));
    }
    return _dio!;
  }

  Future<Map<String, dynamic>> fetchTaskList() async {
    try {
      final res = await _dioGetter.get<Map<String, dynamic>>('/list');
      if (res.data?['status'] == 'ok') {
        Logger.d(_tag, 'Response received: ${res.data}');
        return res.data!;
      }
      throw ArgumentError('The server returns a non-OK status');
    } catch (e) {
      Logger.d(_tag, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addTask(
      Map<String, dynamic> body, int lastKnownRevision) async {
    try {
      final res = await _dioGetter.post<Map<String, dynamic>>('/list',
          data: jsonEncode(body),
          options:
              Options(headers: {'X-Last-Known-Revision': lastKnownRevision}));

      if (res.data?['status'] == 'ok') {
        Logger.d(_tag, 'OK response received: ${res.data}');
        return res.data!;
      }
      throw ArgumentError('The server returns a non-OK status');
    } catch (e) {
      Logger.error(_tag, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> changeTask(
      String taskId, Map<String, dynamic> body, int lastKnownRevision) async {
    try {
      final res = await _dioGetter.put<Map<String, dynamic>>('/list/$taskId',
          data: jsonEncode(body),
          options:
              Options(headers: {'X-Last-Known-Revision': lastKnownRevision}));

      if (res.data?['status'] == 'ok') {
        Logger.d(_tag, 'OK response received: ${res.data}');
        return res.data!;
      }
      throw ArgumentError('The server returns a non-OK status');
    } catch (e) {
      Logger.error(_tag, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteTask(
      String taskId, int lastKnownRevision) async {
    try {
      final res = await _dioGetter.delete<Map<String, dynamic>>('/list/$taskId',
          options:
              Options(headers: {'X-Last-Known-Revision': lastKnownRevision}));

      if (res.data?['status'] == 'ok') {
        Logger.d(_tag, 'OK response received: ${res.data}');
        return res.data!;
      }
      throw ArgumentError('The server returns a non-OK status');
    } catch (e) {
      Logger.error(_tag, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> patchTasks(
      Map<String, dynamic> body, int lastKnownRevision) async {
    try {
      final res = await _dioGetter.patch<Map<String, dynamic>>('/list',
          data: jsonEncode(body),
          options:
              Options(headers: {'X-Last-Known-Revision': lastKnownRevision}));

      if (res.data?['status'] == 'ok') {
        Logger.d(_tag, 'OK response received: ${res.data}');
        return res.data!;
      }
      throw ArgumentError('The server returns a non-OK status');
    } catch (e) {
      Logger.error(_tag, e.toString());
      rethrow;
    }
  }

  void dispose() {
    _dio?.close();
  }
}
