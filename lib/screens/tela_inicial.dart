import 'package:flutter/material.dart';
import 'package:projeto_diario/components/projeto.dart';
import 'package:projeto_diario/data/projeto_dao.dart';
import 'package:projeto_diario/screens/tela_add_projeto.dart';


class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Text('Projetos'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Project>>(
          future: ProjetoDao().findAll(),
          builder: (context, snapshot) {
            List<Project>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
              case ConnectionState.active:
                return const Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Project projeto = items[index];
                        return Project(
                          project: projeto.project,
                          author: projeto.author,
                          data: projeto.data,
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          'Não há nenhum projeto',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('Erro ao carregar projetos ');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => AddProjeto(projetoContext: context),
            ),
          ).then(
            (value) => setState(() {
              print('Recarregando a tela inicial');
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
