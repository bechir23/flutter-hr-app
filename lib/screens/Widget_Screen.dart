import 'package:flutter/material.dart';
import 'package:myapp/models/widgetlist.dart';

class TasksScreen extends StatefulWidget {
  
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int index=0;
final pages=[
Text('Ho;e'),
   Column(
  
    children: [Center(child: Text('Services',style:TextStyle(fontSize: 50,color: Colors.white))),
  
           Expanded(child: TasksList()),
  
    ],
  
  ),
Text('approval'),Text('seetings')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) =>setState(() {
         this.index=index; 
        }),
        height: 60,
        destinations:[
NavigationDestination(icon:Icon( Icons.home_outlined), label:'Home',selectedIcon: Icon(Icons.home)),
NavigationDestination(icon:Icon( Icons.room_service_outlined), label:'Services',selectedIcon: Icon(Icons.room_service)),
NavigationDestination(icon:Icon( Icons.approval_outlined), label:'MyApprovals',selectedIcon: Icon(Icons.approval)),

NavigationDestination(icon:Icon( Icons.settings_accessibility_outlined), label:'Settings',selectedIcon: Icon(Icons.settings_accessibility)),


        ] 
      ),
     // appBar: AppBar(backgroundColor: const Color.fromARGB(255, 238, 35, 103),
     // centerTitle: true,
     //   title:Text('Services',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)
        //action: ,
        //leading,
        //),
        backgroundColor:      Color.fromARGB(255, 223, 75, 124),

       
    )
    
      
    ;
  }
}