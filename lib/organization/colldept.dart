import 'dart:developer';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'colldetails.dart';

class colldept extends StatefulWidget {
  static const screenroute = 'colldept';
  const colldept({super.key});

  @override
  State<colldept> createState() => _colldeptState();
}

class _colldeptState extends State<colldept> {
  final _searchcontroller = TextEditingController();
  List<String> coll = [];
    List<String> filteredcoll = [];
   @override
  void initState() {
    super.initState();
    update();
  }

 

  void search(String query) {
    final suggestions = coll.where((colle) {
      final collename = colle.toLowerCase();
      final input = query.toLowerCase();
      return collename.contains(input);
    }).toList();
    setState(() => coll = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
         Column(
              children: [
                 Padding (
                   padding: const EdgeInsets.all(12.0),
                   child: Container(
                     decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.white,),
                     child:  TextField(controller: _searchcontroller,   onChanged: (value) {
                filterData(value);
              },decoration: const InputDecoration(hintText: 'Search for services...'),)),
                 ), 
                Builder(builder: (context) => 
                   Expanded(
                    child: ListView.builder(
                    
                    itemCount: filteredcoll.length,
                    
                     itemBuilder:(context,index) {
                      return   TextButton(
                    onPressed: () async {  
                      
                
                      
                     // update(); 
                       FirebaseFirestore firestore = FirebaseFirestore.instance;
                
                            QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
                  .collection('colleague')
                  .where('email', isEqualTo: filteredcoll[index])
                  .limit(1)
                  .get();
                
                            if (querySnapshot.docs.isNotEmpty) {
                              QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot.docs[0];
                              Map<String, dynamic> data = documentSnapshot.data();
                   BuildContext detailscontext = context;
                
                          Future.delayed(Duration.zero, () {
                            navigateToColldetails(detailscontext, data);
                          });
                            } else {
                              //print("Document not found");
                            }
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 204, 101, 178),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              filteredcoll[index]
                                  .toString()
                                  .substring(0, 2)
                                  .toUpperCase(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          // ignore: dead_code
                          title: Text(
                            filteredcoll[index] ,
                            style: const TextStyle(color: Colors.white),
                          ),
                          //        subtitle: Text('${data['separationdate']?.toDate().year}-${data['separationdate']?.toDate().month.toString().padLeft(2, '0')}-${data['separationdate']?.toDate().day.toString().padLeft(2, '0')} ${data['separationdate']?.toDate().hour.toString().padLeft(2, '0')}:${data['separationdate']?.toDate().minute.toString().padLeft(2, '0')}:${data['separationdate']?.toDate().second.toString().padLeft(2, '0')}',style: const TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ); 
                    }),
                  ),
                ),
              ],
                       ),
      
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Colleagues',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app)),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  // Navigator.pushNamed(context,'colldept');
                });
              },
            ),
          ]),
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
    );
  }
   Future<void> update() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('colleague').get();

    final List<String> mycoll = querySnapshot.docs
        .map((QueryDocumentSnapshot doc) => doc.get('email') as String)
        .toList();
    ;

    setState(() {
      coll = mycoll;
        filteredcoll = mycoll;
    });
  }
   void navigateToColldetails(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => colldetails(m: data,),
      ),
    );
  }
    void filterData(String query) {
    List<String> filteredList = coll
        .where((email) =>
            email.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredcoll = filteredList;
    });
  }
}
