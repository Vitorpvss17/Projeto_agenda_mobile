import 'package:projeto_diario/components/task.dart';
import 'package:projeto_diario/data/database.dart';
import 'package:projeto_diario/data/projeto_dao.dart';
import 'package:sqflite/sqflite.dart';


class TaskDao {
  static const String _tabletask = 'tasktable';
  static const String _task = 'task_text';
  static const String projecto = 'projeto';
  static const String _taskdata = 'data';
  String get project => projecto;

  static String tableSqlTasks = 'CREATE TABLE $_tabletask('
      '$_task TEXT, '
      '$projecto TEXT REFERENCES ${ProjetoDao.getTableName()}($projecto) ON DELETE CASCADE, '
      '$_taskdata TEXT)';

  Future<int> saveTask(String project, Task task) async {
    final Database bancoDeDados = await getDatabase();
    var itemExists = await findTaskByDate(project, task.date);
    Map<String, dynamic> taskMap = taskToMap(task);

    taskMap[projecto] = project;

    if (itemExists == null) {
      return await bancoDeDados.insert(_tabletask, taskMap,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return await bancoDeDados.update(
        _tabletask,
        taskMap,
        where: '$projecto = ?',
        whereArgs: [project],
      );
    }
  }

  Map<String, dynamic> taskToMap(Task task) {
    final Map<String, dynamic> mapaDetarefas = {};
    mapaDetarefas[_task] = task.taskText;
    mapaDetarefas[projecto] = task.project;
    mapaDetarefas[_taskdata] = task.date.toIso8601String();
    return mapaDetarefas;
  }

  Future<Task?> findTaskByDate(String project, DateTime selectedDate) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tabletask,
      where: '$projecto = ? AND $_taskdata = ?',
      whereArgs: [project, selectedDate.toIso8601String()],
    );

    if (result.isNotEmpty) {
      return taskFromMap(result.first);
    } else {
      return null;
    }
  }

  Task taskFromMap(Map<String, dynamic> map) {
    return Task(
      taskText: map[_task],
      project: map[projecto],
      date: DateTime.parse(map[_taskdata]),
    );
  }

  Future<List<Task>> getAllTasks() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tabletask);

    return result.map((map) {
      return Task(
        taskText: map[_task],
        project: map[projecto],
        date: DateTime.parse(map[_taskdata]),
      );
    }).toList();
  }

}