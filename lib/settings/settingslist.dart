import 'package:flutter/material.dart';

class newsetwidget {
  String? name;
  Icon? icon;
  List<List<String>>? children;
  newsetwidget(this.name, this.icon, this.children);
}

class setwidgets extends ChangeNotifier {
  List<newsetwidget> l = [
    newsetwidget(
        'Leave Tracker',
        const Icon(
          Icons.umbrella,
          color: Colors.red,
        ),
        [
          ['Leave', 'leave']
        ]),
    newsetwidget(
        'Time Tracker',
        const Icon(
          Icons.punch_clock,
          color: Colors.yellow,
        ),
        [
          ['Time Logs', 'timelog'],
          ['Jobs', 'job'],
          ['Projects', 'project'],
          ['Clients', 'client']
        ]),
    newsetwidget(
        'Attendance',
        const Icon(
          Icons.calendar_month,
          color: Color.fromARGB(255, 54, 89, 244),
        ),
        [
          ['Attendance', 'attendace']
        ]),
    newsetwidget(
        'Files',
        const Icon(
          Icons.file_copy,
          color: Color.fromARGB(255, 226, 159, 104),
        ),
        [
          ['Files', 'file']
        ]),
    newsetwidget(
        'Organization',
        const Icon(
          Icons.feed,
          color: Color.fromARGB(255, 36, 189, 209),
        ),
        [
          ['Collagues', 'colldept'],
          ['Exit', 'exit']
        ]),
    newsetwidget(
        'Compensation',
        const Icon(
          Icons.currency_bitcoin,
          color: Color.fromARGB(255, 27, 207, 87),
        ),
        [
          ['Asset', 'asset'],
          ['Benefit', 'benefit']
        ]),
    newsetwidget(
        'Travel',
        const Icon(
          Icons.travel_explore_sharp,
          color: Color.fromARGB(255, 199, 29, 128),
        ),
        [
          ['Travel request', 'request'],
          ['Travel expense', 'expense']
        ]),
    newsetwidget(
        'Tasks',
        const Icon(
          Icons.task,
          color: Color.fromARGB(255, 141, 88, 84),
        ),
        [
          ['Tasks', 'welcone']
        ]),
    newsetwidget(
        'Cases',
        const Icon(
          Icons.query_builder_sharp,
          color: Color.fromARGB(255, 180, 142, 18),
        ),
        [
          ['Cases', 'cases']
        ]),
    newsetwidget('HR letters', const Icon(Icons.share), [
      ['Adress proof', 'proof'],
      ['Bonafide Letter', 'bonafide'],
      ['Experience Letter', 'experience']
    ]),
  ];
}
