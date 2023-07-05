import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/storage/dto/importance_dto.dart';
import 'package:todo_app/storage/dto/task_action_dto.dart';
import 'package:todo_app/storage/dto/task_dto.dart';

const String tableTaskList = 'taskList';
const String columnId = 'id';
const String columnText = 'text';
const String columnDone = 'done';
const String columnChangedAt = 'changed_at';
const String columnCreatedAt = 'created_at';
const String columnLastUpdatedBy = 'last_updated_by';
const String columnDeadline = 'deadline';
const String columnImportance = 'importance';
const String columnActionId = 'action_id';

const String tableTaskActionHistory = 'taskActionHistory';
const String columnAction = 'action';
const String columnTaskId = 'task_id';
const String columnTimestamp = 'timestamp';

class TaskListLocalRepository {
  Database? _db;

  Future open(String path) async {
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<Database> get _databaseGetter async {
    if (_db != null) {
      return _db!;
    }
    final appDir = await getApplicationDocumentsDirectory();
    await open('$appDir/task_list.db');
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS $tableTaskList  (
                     $columnId TEXT PRIMARY KEY,
                     $columnText TEXT NOT NULL,
                     $columnDone INTEGER NOT NULL,
                     $columnImportance INTEGER NOT NULL,
                     $columnChangedAt INTEGER NOT NULL,
                     $columnCreatedAt INTEGER NOT NULL,
                     $columnLastUpdatedBy TEXT NOT NULL,
                     $columnDeadline INTEGER
                     )''');

    await db.execute('''CREATE TABLE IF NOT EXISTS  $tableTaskActionHistory (
                        $columnId INTEGER PRIMARY KEY,
                        $columnAction INTEGER NOT NULL,
                        $columnTimestamp INTEGER NOT NULL,                        
                        $columnTaskId TEXT,
                        FOREIGN KEY($columnTaskId) REFERENCES $tableTaskList($columnId)
                     )''');
  }

  Future<int> insertTask(TaskDto dto) async {
    final db = await _databaseGetter;
    final rowId = await db.insert(tableTaskList, _convertToDbModel(dto));
    await _insertAction(dto.id, ActionType.create);
    return rowId;
  }

  Future<List<TaskDto>> getAllTasks() async {
    final db = await _databaseGetter;
    List<Map<String, dynamic>> allRows = await db.query(tableTaskList);
    List<TaskDto> tasks =
        allRows.map((task) => _convertFromDbModel(task)).toList();
    return tasks;
  }

  Future<TaskDto?> getTask(String id) async {
    final db = await _databaseGetter;
    List<Map<String, dynamic>> maps =
        await db.query(tableTaskList, where: '$columnId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return _convertFromDbModel(maps.first);
    }
    return null;
  }

  Future<int> delete(String id) async {
    final db = await _databaseGetter;

    final numOfRows =
        await db.delete(tableTaskList, where: '$columnId = ?', whereArgs: [id]);
    await _insertAction(id, ActionType.delete);
    return numOfRows;
  }

  Future<int> update(TaskDto dto) async {
    final db = await _databaseGetter;
    final numOfChanges = await db.update(tableTaskList, _convertToDbModel(dto),
        where: '$columnId = ?', whereArgs: [dto.id]);
    await _insertAction(dto.id, ActionType.change);
    return numOfChanges;
  }

  Future<int> deleteAllTasks() async {
    final db = await _databaseGetter;
    final numOfChanges = await db.delete(tableTaskList);
    // await _insertAction(, ActionType.delete);
    return numOfChanges;
  }

  Future<void> saveAll(List<TaskDto> dtos) async {
    final db = await _databaseGetter;
    final batch = db.batch();
    for (final taskDto in dtos) {
      batch.insert(tableTaskList, _convertToDbModel(taskDto),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future close() async => _db!.close();

  Map<String, dynamic> _convertToDbModel(TaskDto dto) {
    final bool done = dto.done;
    final ImportanceDto importance = dto.importance;
    var json = dto.toJson();
    json[columnDone] = done ? 1 : 0;
    json[columnImportance] = importance.index;
    return json;
  }

  TaskDto _convertFromDbModel(Map<String, dynamic> map) {
    final bool done = (map[columnDone] as int) == 1;
    final importanceIndex = (map[columnImportance] as int);
    Map<String, dynamic> copy = Map<String, dynamic>.from(map);
    copy[columnDone] = done;
    copy[columnImportance] = ImportanceDto.values[importanceIndex].name;
    return TaskDto.fromJson(copy);
  }

  Future<int> _insertAction(String taskId, ActionType type) async {
    final db = await _databaseGetter;
    final action =
        TaskActionDto(action: type, timestamp: DateTime.now(), taskId: taskId);
    final actionId = await db.insert(tableTaskActionHistory, action.toJson());
    return actionId;
  }

  Future<List<TaskActionDto>> getAllActions() async {
    final db = await _databaseGetter;
    List<Map<String, dynamic>> allRows = await db.query(tableTaskActionHistory);
    List<TaskActionDto> tasks =
        allRows.map((action) => TaskActionDto.fromJson(action)).toList();
    return tasks;
  }

  Future<int> deleteAllActions() async {
    final db = await _databaseGetter;
    return await db.delete(tableTaskActionHistory);
  }
}
