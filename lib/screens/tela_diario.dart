import 'package:flutter/material.dart';
import 'package:projeto_diario/components/task.dart';
import 'package:projeto_diario/data/task_dao.dart';



class Teladiario extends StatefulWidget {
  final DateTime selectedDay;
  final String project;


   const Teladiario({
    required this.selectedDay, Key? key, required this.project,}) : super(key: key);

  @override
  State<Teladiario> createState() => _TeladiarioState();
}

class _TeladiarioState extends State<Teladiario> {
  TextEditingController taskController = TextEditingController();
  String savedText = "";
  late DateTime selectedDate;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDay;
    loadSavedText();
  }


  Future<void> loadSavedText() async {
    final taskDao = TaskDao();
    final selectedDate = widget.selectedDay;
    final savedTask = await taskDao.findTaskByDate(widget.project, selectedDate);

    if (savedTask != null) {
      savedText = savedTask.taskText;
      taskController.text = savedText;
    }
  }

  Future<void> saveTextToDatabase(String project) async {
    final taskDao = TaskDao();
    final taskText = taskController.text;
    final task = Task(
      taskText: taskText,
      project: project,
      date: selectedDate,
    );

    await taskDao.saveTask(project, task);

    final tasks = await taskDao.getAllTasks();
    for (var task in tasks) {
      print('Task Text: ${task.taskText}');
      print('Project: ${task.project}');
      print('Date: ${task.date}');
    }

    _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Tarefa salva no banco de dados.'),
      ),
    );
  }

  void saveChanges() {
    saveTextToDatabase(widget.project);
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    loadSavedText();
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Text('Escreva suas Tarefas'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'Diário - ${widget.selectedDay.day}/${widget.selectedDay.month}/${widget.selectedDay.year}:'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3),
                      color: Colors.lightBlueAccent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: taskController,
                            decoration: const InputDecoration(
                              hintText: 'Digite aqui',
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveChanges();
                      }
                    },
                    child: const Text('Salvar alterações'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
