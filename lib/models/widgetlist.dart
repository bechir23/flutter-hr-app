import 'package:flutter/material.dart';
import 'package:myapp/models/WidgetData.dart';
import 'package:myapp/models/NewWidget.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return
      
        Consumer<TaskData>(builder: (context, TaskData, child) {
          return 
          
                GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: TaskData.tasks.length,
                 itemBuilder:(context,index) {
                  return  NewTask(name:TaskData.tasks[index].name,press: TaskData.tasks[index].press); 
                })
              
            
          ;},
        )
     
    ;}
    }
     

