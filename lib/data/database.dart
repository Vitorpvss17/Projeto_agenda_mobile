import 'package:path/path.dart';
import 'package:projeto_diario/data/projeto_dao.dart';
import 'package:projeto_diario/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'projeto.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ProjetoDao.tableSql);
    db.execute(TaskDao.tableSqlTasks);
  }, version: 3);
}

