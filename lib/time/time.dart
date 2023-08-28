import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/time/projectdata.dart';
import 'package:provider/provider.dart';

import 'logdetails.dart';

class timelog extends StatefulWidget {
  static const screenroute='timelog';
  const timelog({super.key});

  @override
  State<timelog> createState() => _timelogState();
}

class _timelogState extends State<timelog> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
         body:StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('timelog').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No tasks found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
     
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document)
          {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
             if (data['job'] == null) {
      return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
    }
            return TextButton(
               onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => logdetails(m: data, d: document.id),
              ),
            
          
          );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 204, 101, 178),borderRadius: BorderRadius.all( Radius.circular(20))),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.person),),
                    // ignore: dead_code
                    title: Text(data['job']??'',style: const TextStyle(color: Colors.white),),
                    subtitle:  Text('${data['time']?.toDate().year}-${data['time']?.toDate().month.toString().padLeft(2, '0')}-${data['time']?.toDate().day.toString().padLeft(2, '0')} ',style:const TextStyle(fontSize: 10,color: Colors.black)), 
                  ),
                ),
              ),
            );
          }).toList(),
                  
    
        );
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ) ,
      
      appBar: AppBar(centerTitle:true,title: const Text('Time Logs',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      leading: IconButton(onPressed: (){     Provider.of<projectdata>(context,listen:false).init();
Navigator.pushNamed(context,'time');}, icon:const Icon(Icons.exit_to_app)),
      actions:[ IconButton(icon: const Icon(Icons.add),onPressed: ()  {
     Provider.of<projectdata>(context,listen:false).init();
          setState(() {
         
          Navigator.pushNamed(context,'addtime');
      
        });
        
      },),]),
      
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
    
    
   
   
    

    
    
    

       
    )
    
      
    ;
  }
}


