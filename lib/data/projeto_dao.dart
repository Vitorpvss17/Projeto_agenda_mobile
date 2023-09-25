import 'package:projeto_diario/components/projeto.dart';
import 'package:projeto_diario/data/database.dart';
import 'package:sqflite/sqflite.dart';

class ProjetoDao {


  static String getTableName() {
    return _tableproject;
  }


  static String tableSql = 'CREATE TABLE $_tableproject('
      '$projecto TEXT PRIMARY KEY, '
      '$_author TEXT, '
      '$_data TEXT)';

  static const String _tableproject = 'projectable';
  static const String projecto = 'projeto';
  static const String _author = 'autor';
  static const String _data = 'data';


  save(Project projeto) async {
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(projeto.project);
    Map<String, dynamic> projetoMap = toMap(projeto);
    if (itemExists.isEmpty) {
      return await bancoDeDados.insert(_tableproject, projetoMap);
    } else {
      return await bancoDeDados.update(
        _tableproject,
        projetoMap,
        where: '$projecto = ?',
        whereArgs: [projeto.project],
      );
    }
  }

  Map<String, dynamic> toMap(Project projeto) {
    final Map<String, dynamic> mapaDeprojetos = {};
    mapaDeprojetos[projecto] = projeto.project;
    mapaDeprojetos[_author] = projeto.author;
    mapaDeprojetos[_data] = projeto.data;
    return mapaDeprojetos;

  }

  Future<List<Project>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableproject);
    return toList(result);
  }

  List<Project> toList(List<Map<String, dynamic>> mapaDeProjetos) {
    final List<Project> projetos = [];
    for (Map<String, dynamic> linha in mapaDeProjetos) {
      final Project projeto = Project(
        project: linha[projecto],
        author: linha[_author],
        data: linha[_data],
      );
      projetos.add(projeto);
    }
    return projetos;
  }

  Future<List<Project>> find(String nomeDoProjeto) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tableproject,
      where: '$projecto = ?',
      whereArgs: [nomeDoProjeto],
    );
    return toList(result);
  }

  delete(String nomeDoProjeto) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_tableproject, where: '$projecto = ?', whereArgs: [nomeDoProjeto]);
  }



}
