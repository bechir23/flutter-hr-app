
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/task/valuecheckbox.dart';
import 'package:provider/provider.dart';



class TaskDetails extends StatelessWidget {
  static const  String screenroute='details';

 final  Map <String, dynamic>  m ;
   final String  d  ;
    
   const TaskDetails({super.key, required this.m, required this.d} ); 
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
   actions: [    IconButton(
     onPressed: () {
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return Dialog(
             child: SingleChildScrollView(
               child: Container(
                           width: MediaQuery.of(context).size.width*0.5,
                 decoration: const BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
                   color: Colors.white,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       const Text(
                         'Are you sure you want to discard changes?',
                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                       ),
                       const SizedBox(height: 10),
                       Row(
                         children: [
                           Expanded(
                             child: GestureDetector(
                               onTap: () {
                                FirebaseFirestore.instance.collection('post').doc(d).delete();
                                 Navigator.pushNamed(context, 'welcome');
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(12.0),
                                 child: Container(
                                   padding: const EdgeInsets.all(8.0),
                                   child: const Text('Yes', style: TextStyle(color: Colors.green)),
                                 ),
                               ),
                             ),
                           ),
                           Expanded(
                             child: GestureDetector(
                               onTap: () {
                                 Navigator.pop(context);
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(12.0),
                                 child: Container(
                                   padding: const EdgeInsets.all(8.0),
                                   child: const Text('No', style: TextStyle(color: Colors.red)),
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           );
         },
       );
     },
     icon: const Icon(Icons.delete),
   ),],
   leading:IconButton(onPressed: (){Navigator.pushNamed(context,'welcome');}, icon: const Icon(Icons.exit_to_app_rounded)),



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['email'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('task',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(m['task']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                                          const Text('description',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['description']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('start',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                       

            Text('${m['start']?.toDate().year}-${m['start']?.toDate().month.toString().padLeft(2, '0')}-${m['start']?.toDate().day.toString().padLeft(2, '0')} ${m['start']?.toDate().hour.toString().padLeft(2, '0')}:${m['start']?.toDate().minute.toString().padLeft(2, '0')}:${m['start']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                          const Text('due',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

        Text('${m['due']?.toDate().year}-${m['due']?.toDate().month.toString().padLeft(2, '0')}-${m['due']?.toDate().day.toString().padLeft(2, '0')} ${m['due']?.toDate().hour.toString().padLeft(2, '0')}:${m['due']?.toDate().minute.toString().padLeft(2, '0')}:${m['due']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                          const Text('priority',style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)),
              Text(m['priority']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),

            //  Text(Provider.of<check>(context,listen: false).scale,style:const TextStyle(fontSize: 20,color: Colors.blue),),
        ]


      
      
      ),
    ),



    );
  }
}
 