import 'package:flutter/material.dart';
import 'package:projeto_diario/data/projeto_inherited.dart';
import 'package:projeto_diario/data/task_inherited.dart';
import 'package:projeto_diario/screens/tela_inicial.dart';

class ProjetoDiario extends StatefulWidget {
  const ProjetoDiario({super.key});

  @override
  State<ProjetoDiario> createState() => _ProjetoDiarioState();
}

class _ProjetoDiarioState extends State<ProjetoDiario> {
  final TaskList _taskList = TaskList();


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: ProjetoInherited(child: TaskInherited(notifier: _taskList ,
      child: const TelaInicial())),
    );
  }
}
