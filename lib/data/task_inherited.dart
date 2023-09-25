import 'package:flutter/material.dart';
import 'package:projeto_diario/components/task.dart';


class TaskList extends ChangeNotifier {
  final List<Task> _taskList = [];

  List<Task> get tasks => _taskList;

  void addTask(String taskText, String project, DateTime date) {
    _taskList.add(Task(taskText: taskText, project: project, date: date));
    notifyListeners();
  }
}


class TaskInherited extends InheritedNotifier<TaskList> {
  const TaskInherited({Key? key, required Widget child, required TaskList notifier})
      : super(key: key, child: child, notifier: notifier);

  static TaskInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>()!;
  }
}
