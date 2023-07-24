import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myapp/models/WidgetData.dart';
import 'package:myapp/screens/Widget_Screen.dart';
import 'package:myapp/task/TaskScreen.dart';
import 'package:myapp/task/Priority.dart';
import 'package:myapp/task/valuecheckbox.dart';


import 'package:provider/provider.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [   ChangeNotifierProvider(   create: (context) => TaskData()),
      ChangeNotifierProvider(   create: (context) => check())
],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: debugDisableShadows,
        home:  TasksScreen(),//Scrollbar(isAlwaysShown:true,child: TasksScreen()),
       routes: {AddTask.screenroute :(context) => AddTask(),
       Degree.screenroute:(context) => Degree(),
       },
      ),
    ) ;
    
  }
}