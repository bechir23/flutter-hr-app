import 'package:flutter/material.dart';
import 'package:myapp/models/widget.dart';
class TaskData extends ChangeNotifier{
List<Task>tasks=[
  Task(name:'Leave Tracker',press:''),
  Task(name: 'Time Tracker',press: ''),
  Task(name: 'Attendance',press: ''),
    Task(name: 'Performance',press: '')
,
  Task(name: 'Files',press: '')
,
  Task(name: 'Organization',press: '')
,
  Task(name: 'Travel',press: 'travel')
,
  Task(name: 'Compensation',press: '')
,
  Task(name: 'Annoucements',press: '')
,
  Task(name: 'Employee ',press: '')
,
  Task(name: 'HR Letters',press: '')
,
  Task(name: 'Tasks',press: 'welcome')
,
  Task(name: 'Cases',press: '')

  
  
];

}