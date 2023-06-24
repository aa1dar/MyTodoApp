import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/storage/dto/importance_dto.dart';
import 'package:todo_app/storage/dto/task_dto.dart';
import 'package:todo_app/storage/dto/task_list_dto.dart';
import 'package:todo_app/storage/local/db_repository.dart';
import 'package:todo_app/storage/network/task_list_network_repository.dart';
import 'package:todo_app/utils/logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'dto/task_action_dto.dart';

const _uuid = Uuid();

class MainRepository {
  static const _tag = 'MAIN_REPOSITORY';
  final TaskListLocalRepository _localRepository;
  final TaskListNetworkRepository _networkRepository;
  int? _revision;

  MainRepository(this._localRepository, this._networkRepository);

  Future<List<TaskModel>> fetchTasks() async {
    Logger.d(_tag, 'Start sync data');
    final taskListFromNetwork = await _networkRepository.fetchTaskList();
    _revision = taskListFromNetwork.revision;

    final actions = await _localRepository.getAllActions();
    final taskListFromLocal = await _localRepository.getAllTasks();

    TaskListDto newNetworkList;
    if (actions.isNotEmpty) {
      newNetworkList =
          getSyncChanges(actions, taskListFromNetwork, taskListFromLocal);
      _revision = await _networkRepository.patchTasks(newNetworkList);
    } else {
      newNetworkList = taskListFromNetwork;
    }

    await _clearLocalRepositories();
    await _localRepository.saveAll(newNetworkList.list);

    Logger.d(_tag, 'Finish sync data');

    return newNetworkList.list.map((e) => e.toModel()).toList();
  }

  Future<void> _clearLocalRepositories() => Future.wait(
      [_localRepository.deleteAllActions(), _localRepository.deleteAllTasks()]);

  TaskListDto getSyncChanges(List<TaskActionDto> actions,
      TaskListDto taskListFromNetwork, List<TaskDto> localData) {
    final List<TaskDto> copy = List.from(taskListFromNetwork.list);

    for (var action in actions) {
      if (action.action == ActionType.delete) {
        copy.removeWhere((element) => element.id == action.taskId);
      }
      if (action.action == ActionType.change) {
        // TODO: Implement more logical behavior
        final indexNetwork =
            copy.indexWhere((element) => element.id == action.taskId);
        final indexLocal =
            localData.indexWhere((element) => element.id == action.taskId);

        if (indexLocal != -1) {
          if (indexNetwork != -1) {
            copy[indexNetwork] = localData[indexLocal];
          } else {
            copy.add(localData[indexLocal]);
          }
        }
      }

      if (action.action == ActionType.create) {
        final indexLocal =
            localData.indexWhere((element) => element.id == action.taskId);
        copy.add(localData[indexLocal]);
      }
    }

    return TaskListDto(list: copy, revision: _revision!);
  }

  Future<TaskModel?> addTask(TaskModel newModel) async {
    Logger.d(_tag, 'Add task: $newModel');

    final newPriority = ImportanceDto.values[newModel.priority.index];
    final TaskDto dto = TaskDto(
        id: _uuid.v4(),
        text: newModel.description,
        importance: newPriority,
        done: newModel.isCompleted,
        deadline: newModel.deadline,
        createdAt: DateTime.now(),
        changedAt: DateTime.now(),
        lastUpdatedBy: '111');
    final rowId = await _localRepository.insertTask(dto);
    if (rowId == 0) {
      return null;
    }
    return dto.toModel();
  }

  Future<TaskModel> changeTask(String taskId, TaskModel newModel) async {
    Logger.d(_tag, 'Change task: $newModel');
    final oldTaskInfo = await _localRepository.getTask(taskId);
    final newTask = TaskDto(
        id: oldTaskInfo!.id,
        text: newModel.description,
        importance: ImportanceDtoMapper.fromModel(newModel.priority),
        done: newModel.isCompleted,
        deadline: newModel.deadline,
        changedAt: DateTime.now(),
        createdAt: oldTaskInfo.createdAt,
        lastUpdatedBy: oldTaskInfo.lastUpdatedBy);
    await _localRepository.update(newTask);
    return newTask.toModel();
  }

  Future<TaskModel?> toogle(String taskId) async {
    Logger.d(_tag, 'Toogle: $taskId');
    final oldTaskInfo = await _localRepository.getTask(taskId);
    if (oldTaskInfo == null) {
      return null;
    }
    final newModel = oldTaskInfo.copyWith(
        changedAt: DateTime.now(), done: !oldTaskInfo.done);
    await _localRepository.update(newModel);
    return newModel.toModel();
  }

  Future<void> delete(String taskId) async {
    Logger.d(_tag, 'Delete: $taskId');
    await _localRepository.delete(taskId);
  }

  void dispose() {
    _localRepository.close();
    _networkRepository.dispose();
  }
}
