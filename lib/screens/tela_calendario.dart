import 'package:flutter/material.dart';
import 'package:projeto_diario/components/task.dart';
import 'package:projeto_diario/data/task_dao.dart';
import 'package:projeto_diario/screens/tela_diario.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(2019, 1, 1);
var lastDay = DateTime(now.year, 12, 31);

class TelaCalendario extends StatefulWidget {
  final String project;
  const TelaCalendario({Key? key, required this.project,}) : super(key: key);

  @override
  State<TelaCalendario> createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> {
  CalendarFormat format = CalendarFormat.month;


  Widget _buildTeladiario(BuildContext context, DateTime selectedDay, String project) {
    final taskDao = TaskDao();
    return FutureBuilder<Task?>(
      future: taskDao.findTaskByDate(project, selectedDay),
      builder: (context, snapshot) {

        return Teladiario(selectedDay: selectedDay, project: widget.project);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Text('Minhas Datas'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'pt_BR',
              focusedDay: now,
              firstDay: firstDay,
              lastDay: lastDay,
              calendarFormat: format,
              onDaySelected: (selectedDay, focusedDay) async {
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contextNew) =>
                        _buildTeladiario(contextNew, selectedDay, widget.project),
                  ),
                );
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableCalendarFormats: const {
                CalendarFormat.month: 'mês',
                CalendarFormat.week: 'semana',
                CalendarFormat.twoWeeks: '2 semanas',
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.rectangle,
                ),
              ),
              calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
                String text;
                if (day.weekday == DateTime.sunday) {
                  text = 'Dom';
                } else if (day.weekday == DateTime.monday) {
                  text = 'Seg';
                } else if (day.weekday == DateTime.tuesday) {
                  text = 'Ter';
                } else if (day.weekday == DateTime.wednesday) {
                  text = 'Qua';
                } else if (day.weekday == DateTime.thursday) {
                  text = 'Qui';
                } else if (day.weekday == DateTime.friday) {
                  text = 'Sex';
                } else if (day.weekday == DateTime.saturday) {
                  text = 'Sab';
                } else {
                  text = 'err';
                }
                return Center(
                  child: Text(text),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}