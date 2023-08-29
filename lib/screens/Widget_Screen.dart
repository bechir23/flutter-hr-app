import 'package:flutter/material.dart';
import 'package:myapp/chat/chatview.dart';
import 'package:myapp/models/widgetlist.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class TasksScreen extends StatefulWidget {
  static const screenroute = 'navigation';
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // int index=0;
  final pages = [const TasksList(), const chatview(), const Text('seetings')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[Provider.of<pos>(context, listen: false).index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: Provider.of<pos>(context, listen: false).index,
          onDestinationSelected: (index) => setState(() {
                Provider.of<pos>(context, listen: false).index = index;
              }),
          height: 60,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.room_service_outlined),
                label: 'Services',
                selectedIcon: Icon(Icons.room_service)),
            NavigationDestination(
                icon: Icon(Icons.messenger),
                label: 'MessageMe',
                selectedIcon: Icon(Icons.approval)),
            NavigationDestination(
                icon: Icon(Icons.settings_accessibility_outlined),
                label: 'Settings',
                selectedIcon: Icon(Icons.settings_accessibility)),
          ]),
      // appBar: AppBar(backgroundColor: const Color.fromARGB(255, 238, 35, 103),
      // centerTitle: true,
      //   title:Text('Services',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)
      //action: ,
      //leading,
      //),

      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
    );
  }
}
