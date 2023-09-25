import 'package:flutter/material.dart';
import 'package:projeto_diario/components/projeto.dart';
import 'package:projeto_diario/data/projeto_dao.dart';

class AddProjeto extends StatefulWidget {
  const AddProjeto({Key? key, required this.projetoContext}) : super(key: key);
  final BuildContext projetoContext;

  @override
  State<AddProjeto> createState() => _AddProjetoState();
}

class _AddProjetoState extends State<AddProjeto> {
  TextEditingController projectController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Projeto'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 550,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome do projeto';
                        }
                        return null;
                      },
                      controller: projectController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Projeto',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome do autor';
                        }
                        return null;
                      },
                      controller: authorController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Autor',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira a data de inicio do projeto: Ex(dd/mm/aaaa)';
                        }
                        return null;
                      },
                      controller: dataController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'data Ex: (dd/mm/aaaa)',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ProjetoDao().save(
                          Project(
                            project: projectController.text,
                            author: authorController.text,
                            data: dataController.text,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Criando novo projeto'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Adicionar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

