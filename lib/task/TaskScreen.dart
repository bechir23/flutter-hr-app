import 'package:flutter/material.dart';
import 'package:myapp/task/addtaskscreen.dart';
import 'package:myapp/task/Listtasks.dart';
import 'package:myapp/task/valuecheckbox.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  static const String screenroute='welcome';
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 240, 128, 165),
     floatingActionButton: FloatingActionButton(onPressed:()
     {showModalBottomSheet(isScrollControlled: true,context: context, builder: (context) => 
     SingleChildScrollView(
    
     child: Container(
      padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,),
      child: AddTaskScreen()),
       
     ));},
    backgroundColor: Color.fromARGB(255, 238, 238, 237),
      child: Icon(Icons.add,color: Colors.pink,),
          
          ),
    
    body: list(),
    );
  }
}