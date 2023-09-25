import 'package:flutter/material.dart';
import 'package:projeto_diario/components/projeto.dart';

class ProjetoInherited extends InheritedWidget {
  ProjetoInherited({Key? key, required Widget child}) : super(key: key, child: child);

  final List <Project> projectList = [];

  void newProject(String project, String author, String data){
    projectList.add(Project(project: project, author: author, data: data));

  }

  static ProjetoInherited of(BuildContext context) {
    final ProjetoInherited ? result = context.dependOnInheritedWidgetOfExactType<ProjetoInherited>();
    assert(result != null, 'No ProjectInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ProjetoInherited oldWidget) {
    return oldWidget.projectList.length != projectList.length;
  }
}
