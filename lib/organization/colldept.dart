import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'colldetails.dart';

class colldept extends StatefulWidget {
  static const screenroute='colldept';
  const colldept({super.key});

  @override
  State<colldept> createState() => _colldeptState();
}

class _colldeptState extends State<colldept> {
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
         body:StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('colleague').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No tasks found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
     
       
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document)
          {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
             if (data['email'] == null) {
      return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
    }
            return TextButton(
               onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => colldetails(m: data, d: document.id),
              ),
            
          
          );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 204, 101, 178),borderRadius: BorderRadius.all( Radius.circular(20))),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.white,child: Text(data['email'].toString().substring(0,2).toUpperCase(),style: const TextStyle(color: Colors.blue),),),
                    // ignore: dead_code
                    title: Text(data['email']??'',style: const TextStyle(color: Colors.white),),
                            //        subtitle: Text('${data['separationdate']?.toDate().year}-${data['separationdate']?.toDate().month.toString().padLeft(2, '0')}-${data['separationdate']?.toDate().day.toString().padLeft(2, '0')} ${data['separationdate']?.toDate().hour.toString().padLeft(2, '0')}:${data['separationdate']?.toDate().minute.toString().padLeft(2, '0')}:${data['separationdate']?.toDate().second.toString().padLeft(2, '0')}',style: const TextStyle(color: Colors.white),),
            
                  ),
                ),
              ),
            );
          }).toList(),
                  
    
        );
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ) ,




    appBar: AppBar(centerTitle:true,title: const Text('Colleagues',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.exit_to_app)),
      actions:[ IconButton(icon: const Icon(Icons.add),onPressed: ()  {
     
          setState(() {
         
         // Navigator.pushNamed(context,'colldept');
      
        });
        
      },),]),
      
      
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
    
    
   
   
    

    
    
    

       
    )
    
      
    ;
  }
}





