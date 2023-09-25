import 'package:flutter/material.dart';
import 'package:projeto_diario/data/projeto_dao.dart';
import 'package:projeto_diario/screens/tela_calendario.dart';

class Project extends StatelessWidget {
  final String project;
  final String author;
  final String data;


  const Project({
    required this.project,
    required this.author,
    required this.data,
    Key? key,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => TelaCalendario(project: project),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black,
              ),
              height: 100,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Projeto: $project',
                      style: const TextStyle(fontSize: 32, color: Colors.amber),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5, top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(author, style: const TextStyle(fontSize: 18, color: Colors.amber)),
                        Text('Inicio: $data', style: const TextStyle(fontSize: 18, color: Colors.amber)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 350.0),
              child: IconButton(
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete? '),
                        content: const Text('Deseja deletar a tarefa? '),
                        actions: [
                          TextButton(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              ProjetoDao().delete(project);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            )
          ],
        ),
      ),
    );
  }
}