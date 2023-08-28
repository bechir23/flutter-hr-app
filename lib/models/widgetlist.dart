import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/NewWidget.dart';
import 'package:myapp/models/widget.dart';


class TasksList extends StatefulWidget {
static const screenroute='main';
const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final user =FirebaseAuth.instance.currentUser!;
  List<Task> tasks=alltasks;
  final _searchcontroller=TextEditingController();
  void search(String query){
final suggestions=alltasks.where((task) {
  final taskname=task.name.toLowerCase();
  final input=query.toLowerCase();
  return taskname.contains(input);}).toList();
  setState(() => tasks=suggestions);
}


  
 

  
  @override
  Widget build(BuildContext context) {
    return
      
        Scaffold( appBar: AppBar(leading: CircleAvatar(backgroundColor: Colors.purple,child: Text(user.email.toString().substring(0,2).toUpperCase(),style: const TextStyle(color: Colors.white),),) ,actions: [IconButton(onPressed: (){Navigator.pushNamed(context, 'colldept');}, icon: const Icon(Icons.search))],centerTitle:true,title:const  Text('Services',style:  TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),),
      
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),

          body: 
             Column(
              children: [
                 Padding (
                   padding: const EdgeInsets.all(12.0),
                   child: Container(
                     decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.white,),
                     child:  TextField(controller: _searchcontroller,onChanged: search,decoration: const InputDecoration(hintText: 'Search for services...'),)),
                 ), 
                Expanded(
                  child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                  ,
                  
                  ),
                  itemCount: tasks.length,
                  
                   itemBuilder:(context,index) {
                    return  NewTask(name:tasks[index].name,press: tasks[index].press,ImageUrl:tasks[index].ImageUrl ,); 
                  }),
                ),
              ],
                       ),
          
        );
      
  
    
    }

     

}