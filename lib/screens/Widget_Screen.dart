import 'package:flutter/material.dart';
import 'package:myapp/models/widgetlist.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class TasksScreen extends StatefulWidget {
  static const screenroute='navigation';
  const TasksScreen({super.key});

  
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
 // int index=0;
final pages=[
const Text('Ho;e'),
   
  
         const TasksList(),
  
    
  
  
const Text('approval'),const Text('seetings')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: pages[Provider.of<pos>(context,listen: false).index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: Provider.of<pos>(context,listen: false).index,
        onDestinationSelected: (index) =>setState(() {
         Provider.of<pos>(context,listen: false).index=index; 
        }),
        height: 60,
        destinations:const [
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
       
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),

       
    )
    
      
    ;
  }
}