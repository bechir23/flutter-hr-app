
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



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
   actions: [ IconButton(onPressed: (){FirebaseFirestore.instance.collection('post').doc(d).delete();
         Navigator.pop(context);}, icon: const Icon(Icons.done_all)),],
   leading:Container(
     child: Row(children: [
     
       
      
   Expanded(child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.exit_to_app_rounded))),
   const SizedBox(width: 10,),
     //email==d['email] ? .......:container 
       Expanded(child: IconButton(onPressed: (){FirebaseFirestore.instance.collection('post').doc(d).delete();
       Navigator.pop(context);}, icon: const Icon(Icons.delete)))

   
   
   
     ]),
   ),



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

        Text('${m['due']?.toDate().year}-${m['due']?.toDate().month.toString().padLeft(2, '0')}-${m['due']?.toDate().day.toString().padLeft(2, '0')} ${m['due']?.toDate().hour.toString().padLeft(2, '0')}:${m['due']?.toDate().minute.toString().padLeft(2, '0')}:${m['due']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)),
                                          const Text('priority',style:TextStyle(fontSize: 20,color:Colors.blue),),

              Text(m['priority']?? 'No Priority found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
        ]


      
      
      ),
    ),



    );
  }
}
 