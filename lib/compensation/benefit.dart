import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/compensation/medical.dart';
import 'package:provider/provider.dart';

import 'addbenefit.dart';
import 'benefitdetails.dart';


class benefit extends StatefulWidget {
  static const screenroute='benefit';
  const benefit({super.key});

  @override
  State<benefit> createState() => _benefitState();
}

class _benefitState extends State<benefit> {
 
  Future clearCollection() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('medical');

  QuerySnapshot snapshot = await collectionRef.get();

  // Create a batch operation to delete all documents
  WriteBatch batch = FirebaseFirestore.instance.batch();
  for (var doc in snapshot.docs) {
    batch.delete(doc.reference);
  }

  // Commit the batch operation
  await batch.commit();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body:StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tabbenefit').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No Trips found'));}
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
                builder: (context) => benefitdetails(m: data, d: document.id,l:Provider.of<medicaldata>(context,listen: false).documents),
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
                    
                  ),
                ),
              ),
            );
          }).toList(),
                  
    
        );
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ),


        
      
      appBar: AppBar(centerTitle:true,title: const Text('Benefit',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: () {Navigator.pushNamed(context,'compensation');
        
      })),
      
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
     floatingActionButton: FloatingActionButton(onPressed:()
     {clearCollection();
   showModalBottomSheet(isScrollControlled: true,context: context, builder: (context) => 
     SingleChildScrollView(
    
     child: Container(
      padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,),
      child: const addbenefit()),
       
     ));
       },
    backgroundColor:Colors.white,
      child: const Icon(Icons.add,color: Colors.pink,),
          
          ),
    
   
   
    

    
    
    

       
    );
  }
}