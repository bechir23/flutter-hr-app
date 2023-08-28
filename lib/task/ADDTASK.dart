
import 'package:flutter/material.dart';
import 'package:myapp/task/addtaskscreen.dart';
import 'package:myapp/task/alltasks.dart';
import 'package:myapp/task/mytasks.dart';
import 'package:myapp/task/taskpos.dart';
import 'package:myapp/task/valuecheckbox.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class AddTask extends StatefulWidget {
  static const String screenroute='welcome';
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
 int index=0;
final pages=[

   
  
  
  
             const mytasks(),    const alltasks()
  
    ];
  
  


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
         body: pages[Provider.of<taskpos>(context,listen:false).index],
       
      bottomNavigationBar: NavigationBar(
        selectedIndex:Provider.of<taskpos>(context,listen:false).index ,
        onDestinationSelected: (index) =>setState(() {
         Provider.of<taskpos>(context,listen:false).index=index; 
        }),
        height: 60,
        destinations:const  [
NavigationDestination(icon:Icon( Icons.my_library_add), label:'My Tasks',),
NavigationDestination(icon:Icon( Icons.library_add), label:'All Tasks'),



        ] 
      ),
      appBar: AppBar(centerTitle:true,title: const Text('List of Taks',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: () { Provider.of<pos>(context,listen: false).index=1;Navigator.pushNamed(context,'navigation');        
 Provider.of<check>(context,listen: false).init();})),
     
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
     floatingActionButton: FloatingActionButton(onPressed:()
     {Provider.of<check>(context,listen: false).init();
      showModalBottomSheet(isScrollControlled: true,context: context, builder: (context) => 
     SingleChildScrollView(
    
     child: Container(
      padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,),
      child: const AddTaskScreen()),
       
     ));},
    backgroundColor:Colors.white,
      child: const Icon(Icons.add,color: Colors.pink,),
          
          ),
    
   
   
    

    
    
    

       
    )
    
      
    ;
  }
}
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   // body: StreamBuilder<QuerySnapshot>(
   //   stream: FirebaseFirestore.instance.collection('post').orderBy('start').snapshots(),
  //    builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
 //     {
 //       if(snapshot.hasError) { return const Center(child: const Text('No tasks found'));}
  //      if (snapshot.connectionState==ConnectionState.waiting)
 //       {return const Center(child: CircularProgressIndicator());}
     
 //       return ListView(
 // /        children: snapshot.data!.docs.map((DocumentSnapshot document)
   //       {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
  //           if (data == null || data['email'] == null) {
  //    return SizedBox(); // You can return an empty widget or handle this case as per your requirement.
 //   }
 //           return TextButton(
  //            onPressed: () {
   //             Navigator.push(
   //           context,
   //           MaterialPageRoute(
   //             builder: (context) => TaskDetails(m: data, d: document.id),
    //          ),
            
          
    //      );
    //          },
       //       child: Padding(
       //         padding: const EdgeInsets.all(8.0),
       //         child: Container(
      //            padding:EdgeInsets.all(12.0),
      //            decoration: BoxDecoration(color: Color.fromARGB(255, 204, 101, 178),borderRadius: BorderRadius.all( Radius.circular(20))),
      //            child: ListTile(
      //              leading: CircleAvatar(child: Text(data['email'].toString().substring(0,2).toUpperCase(),style: TextStyle(color: Colors.blue),),backgroundColor: Colors.white,),
                    // ignore: dead_code
      //              title: Text(data['description']??'',style: TextStyle(color: Colors.white),),
       //             subtitle: Text(data['email']??'',style: TextStyle(color: Colors.white),),
        //          ),
     //           ),
     //         ),
   //         );
   //       }).toList(),
                  
    
     //   );
// if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));

             
  //  },
    
    
  //  ));
 // }
//}

