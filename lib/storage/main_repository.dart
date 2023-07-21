import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/storage/dto/importance_dto.dart';
import 'package:todo_app/storage/dto/task_dto.dart';
import 'package:todo_app/storage/dto/task_list_dto.dart';
import 'package:todo_app/storage/local/revision_local_repository.dart';
import 'package:todo_app/storage/local/task_list_local_repository.dart';
import 'package:todo_app/storage/network/task_list_network_repository.dart';
import 'package:todo_app/utils/logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'dto/task_action_dto.dart';

const _uuid = Uuid();

class MainRepository {
  static const _tag = 'MAIN_REPOSITORY';
  final TaskListLocalRepository _localRepository;
  final TaskListNetworkRepository _networkRepository;
  final RevisionLocalRepository _revisionLocalRepository;
  bool localSavingOnly = false;

  MainRepository(this._localRepository, this._networkRepository,
      this._revisionLocalRepository);

  Future<List<TaskModel>> fetchTasks() async {
    Logger.d(_tag, 'Start sync data');

    final taskListFromNetwork = await _getTasksFromNetwork();
    final taskListFromLocal = await _localRepository.getAllTasks();

    // Problems with server/No internet connection condition
    if (taskListFromNetwork == null) {
      localSavingOnly = true;
      return taskListFromLocal.map((e) => e.toModel()).toList();
    }

    // Default behavior with syncing changes from local to remote db
    final actions = await _localRepository.getAllActions();

    final syncedTaskList = await _getSyncedTaskList(
        actions, taskListFromNetwork, taskListFromLocal);

    Logger.d(_tag, 'Finish sync data');

    return syncedTaskList.map((e) => e.toModel()).toList();
  }

  Future<List<TaskDto>> _getSyncedTaskList(List<TaskActionDto> actions,
      List<TaskDto> network, List<TaskDto> local) async {
    List<TaskDto> syncedList = [];

    final localRevision =
        await _revisionLocalRepository.getLocalRevision() ?? -1;
    final networkRevision =
        await _revisionLocalRepository.getNetworkRevision() ?? -1;

    // Condition: No changes
    if (actions.isEmpty && localRevision == networkRevision) {
      syncedList = network;

      // Condition: Local data is irrelevant
    } else if (actions.isEmpty && localRevision != networkRevision) {
      syncedList = network;
      await _refreshLocalStorageWithTasks(syncedList, networkRevision);

      // Condition: Need to send unsynced tasks to remote storage
    } else if (actions.isNotEmpty && localRevision == networkRevision) {
      syncedList = local;
      await _sendTaskPatchToNetwork(syncedList).then((newRevision) {
        if (newRevision != null) {
          _revisionLocalRepository.saveLocalRevision(newRevision);
        }
      });

      // Condition: Conflicts
    } else if (actions.isNotEmpty && localRevision != networkRevision) {
      syncedList = _mergeChanges(actions, network, local);
      final newRevision = await _sendTaskPatchToNetwork(syncedList);

      if (newRevision != null) {
        await _refreshLocalStorageWithTasks(syncedList, newRevision);
      }
    }

    return syncedList;
  }

  Future<int?> _sendTaskPatchToNetwork(List<TaskDto> patchedTasks) async {
    try {
      final lastKnownRevision =
          await _revisionLocalRepository.getNetworkRevision();

      final newNetworkRevision = await _networkRepository.patchTasks(
          TaskListDto(list: patchedTasks, revision: lastKnownRevision!));
      _revisionLocalRepository.saveNetworkRevision(newNetworkRevision);
      return newNetworkRevision;
    } catch (e) {
      Logger.info(_tag, 'Could not patch data to remote repository');
      return null;
    }
  }

  Future<List<TaskDto>?> _getTasksFromNetwork() async {
    try {
      final taskListFromNetwork = await _networkRepository.fetchTaskList();
      await _revisionLocalRepository
          .saveNetworkRevision(taskListFromNetwork.revision);
      return taskListFromNetwork.list;
    } catch (e) {
      Logger.info(_tag, 'Could not get data from remote repository');
      return null;
    }
  }

  Future<void> _refreshLocalStorageWithTasks(
      List<TaskDto> dtos, int savedRevision) async {
    await _clearLocalRepositories();
    await _localRepository.saveAll(dtos);
    await _revisionLocalRepository.saveLocalRevision(savedRevision);
  }

  Future<void> _clearLocalRepositories() => Future.wait(
      [_localRepository.deleteAllActions(), _localRepository.deleteAllTasks()]);

  List<TaskDto> _mergeChanges(List<TaskActionDto> actions,
      List<TaskDto> taskListFromNetwork, List<TaskDto> localData) {
    final List<TaskDto> networkSnap = List.from(taskListFromNetwork);

    for (final action in actions) {
      switch (action.action) {
        case ActionType.delete:
          // Delete the task if it was not deleted earlier and
          // the deletion was done before the last modification of the task
          final indexNetwork =
              networkSnap.indexWhere((element) => element.id == action.taskId);
          if (indexNetwork != -1) {
            final actionTime = action.timestamp;
            final timeOfLastChangeInNetwork =
                networkSnap[indexNetwork].changedAt ??
                    actionTime.add(const Duration(seconds: -1));

            if (actionTime.isAfter(timeOfLastChangeInNetwork)) {
              networkSnap.removeWhere((element) => element.id == action.taskId);
            }
          }
          break;
        case ActionType.change:
          final indexNetwork =
              networkSnap.indexWhere((element) => element.id == action.taskId);
          final indexLocal =
              localData.indexWhere((element) => element.id == action.taskId);

          // Check if the task has not been deleted in local &&
          // Check if the task exists in remote storage
          if (indexLocal != -1 && indexNetwork != -1) {
            final changeTime = action.timestamp;

            // Rewrite the task if the changedAt field is null
            final networkChangeTime = networkSnap[indexNetwork].changedAt ??
                changeTime.add(const Duration(seconds: -1));

            if (changeTime.isAfter(networkChangeTime)) {
              networkSnap[indexNetwork] = localData[indexLocal];
            }
          }
          break;
        case ActionType.create:
          final indexLocal =
              localData.indexWhere((element) => element.id == action.taskId);
          if (indexLocal != -1) {
            networkSnap.add(localData[indexLocal]);
          }
          break;
      }
    }

    return networkSnap;
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
    if (!localSavingOnly) {
      await fetchTasks();
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
    if (!localSavingOnly) {
      await fetchTasks();
    }
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
    if (!localSavingOnly) {
      await fetchTasks();
    }
    return newModel.toModel();
  }

  Future<void> delete(String taskId) async {
    Logger.d(_tag, 'Delete: $taskId');
    await _localRepository.delete(taskId);
    if (!localSavingOnly) {
      await fetchTasks();
    }
  }

  void dispose() {
    _localRepository.close();
    _networkRepository.dispose();
  }
}
