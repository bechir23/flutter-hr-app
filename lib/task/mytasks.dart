import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/task/taskdetails.dart';
import 'package:provider/provider.dart';

class mytasks extends StatelessWidget {
  const mytasks({super.key});

  @override
  Widget build(BuildContext context) {
    
     
        return Scaffold(
           backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('post').orderBy('start').snapshots(),
            builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
            {
        if(snapshot.hasError) { return const Center(child: Text('No tasks found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
        return ListView.builder(itemCount: snapshot.data!.docs.length,
        itemBuilder:(context, index) {
          DocumentSnapshot document= snapshot.data!.docs[index];
          Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
            if (data['email'] == null || FirebaseAuth.instance.currentUser?.email!=data['email']) {
           return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
          }
            return TextButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetails(m: data, d: document.id,i:index),
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
                    title: Text(data['description']??'',style: const TextStyle(color: Colors.white),),
                    subtitle: Text(data['email']??'',style: const TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            );
          }
                  
          
        );
        // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
        
             
          },
          
          
          ),
        );
        
        
        
      
      }
      }