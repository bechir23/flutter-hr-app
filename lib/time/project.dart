import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/time/projectdata.dart';
import 'package:myapp/time/projectdetails.dart';
import 'package:provider/provider.dart';

class project extends StatefulWidget {
  static const String screenroute='project';
  const project({super.key});

  @override
  State<project> createState() => _projectState();
}

class _projectState extends State<project> {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
         body:StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('project').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No tasks found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
     
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document)
          {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
             if (data['name'] == null) {
      return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
    }
            return TextButton(
               onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => projectdetails(m: data, d: document.id),
              ),
            
          
          );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 204, 101, 178),borderRadius: BorderRadius.all( Radius.circular(20))),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.work_outline_outlined),),
                    // ignore: dead_code
                    title: Text(data['name']??'',style: const TextStyle(color: Colors.white),),
            
                  ),
                ),
              ),
            );
          }).toList(),
                  
    
        );
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ) ,
      
      appBar: AppBar(centerTitle:true,title: const Text('Projects',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      leading: IconButton(onPressed: (){     Provider.of<projectdata>(context,listen:false).init();
Navigator.pushNamed(context,'time');}, icon:const  Icon(Icons.exit_to_app)),
      actions:[ IconButton(icon: const Icon(Icons.add),onPressed: ()  {
          Provider.of<projectdata>(context,listen:false).init();

          setState(() {
         
          Navigator.pushNamed(context,'addproject');
      
        });
        
      },),]),
      
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
    
    
   
   
    

    
    
    

       
    )
    
      
    ;
  }
}



 