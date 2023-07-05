import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/utils/logger/logger.dart';

import 'api_service.dart';
import '../dto/task_dto.dart';
import '../dto/task_list_dto.dart';

class TaskListNetworkRepository {
  static const _tag = 'NETWORK_REPOSITORY';
  static const _pingAddress = 'example.com';
  final ApiService _taskListApi;

  TaskListNetworkRepository(this._taskListApi);

  Future<TaskListDto> fetchTaskList() async {
    try {
      final res = await _taskListApi.fetchTaskList();
      final TaskListDto taskListDto = TaskListDto.fromJson(res);
      return taskListDto;
    } on DioException catch (e) {
      if (e.response != null) {
        Logger.d(_tag, e.response!.data.toString());
        Logger.d(_tag, e.response!.headers.toString());
        Logger.d(_tag, e.response!.requestOptions.toString());
      } else {
        Logger.d(_tag, e.requestOptions.toString());
        Logger.d(_tag, e.message.toString());
      }
      rethrow;
    }
  }

  Future<int> sendNewTask(TaskDto dto, int lastKnownRevision) async {
    final body = {"element": dto.toJson()};
    try {
      final res = await _taskListApi.addTask(body, lastKnownRevision);
      return res['revision'];
    } on DioException catch (e) {
      if (e.response != null) {
        Logger.error(_tag, e.response!.data.toString());
      } else {
        Logger.error(_tag, e.requestOptions.toString());
        Logger.error(_tag, e.message.toString());
      }
      rethrow;
    }
  }

  Future<int> changeTask(
      String taskId, TaskDto dto, int lastKnownRevision) async {
    final body = {"element": dto.toJson()};
    try {
      final res =
          await _taskListApi.changeTask(taskId, body, lastKnownRevision);
      return res['revision'];
    } on DioException catch (e) {
      if (e.response != null) {
        Logger.error(_tag, e.response!.data.toString());
      } else {
        Logger.error(_tag, e.requestOptions.toString());
        Logger.error(_tag, e.message.toString());
      }
      rethrow;
    }
  }

  Future<int> deleteTask(String taskId, int lastKnownRevision) async {
    try {
      final res = await _taskListApi.deleteTask(taskId, lastKnownRevision);
      return res['revision'];
    } on DioException catch (e) {
      if (e.response != null) {
        Logger.error(_tag, e.response!.data.toString());
      } else {
        Logger.error(_tag, e.requestOptions.toString());
        Logger.error(_tag, e.message.toString());
      }
      rethrow;
    }
  }

  Future<int> patchTasks(TaskListDto dto) async {
    final body = {"list": dto.list.map((e) => e.toJson()).toList()};
    try {
      final res = await _taskListApi.patchTasks(body, dto.revision);
      return res['revision'];
    } on DioException catch (e) {
      if (e.response != null) {
        Logger.error(_tag, e.response!.data.toString());
      } else {
        Logger.error(_tag, e.requestOptions.toString());
        Logger.error(_tag, e.message.toString());
      }
      rethrow;
    }
  }

  Future<bool> _hasNetwork() async {
    try {
      final result = await InternetAddress.lookup(_pingAddress);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void dispose() {
    _taskListApi.dispose();
  }
}
