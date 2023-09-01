import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';
import 'messenger.dart';

class chatview extends StatefulWidget {
  static const String screenroute = 'chatview';
  const chatview({super.key});

  @override
  State<chatview> createState() => _chatviewState();
}

class _chatviewState extends State<chatview> {
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
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((12)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: _searchcontroller,
                    onChanged: (value) {
                      filterData(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search for colleagues...',
                      suffixIcon: Icon(Icons.search),
                    ),
                  )),
            ),
            Builder(
              builder: (context) => Expanded(
                child: ListView.builder(
                    itemCount: filteredcoll.length,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () async {
                          Provider.of<pos>(context, listen: false).index = 1;

                          // update();
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;

                          QuerySnapshot<Map<String, dynamic>> querySnapshot =
                              await firestore
                                  .collection('colleague')
                                  .where('email',
                                      isEqualTo: filteredcoll[index])
                                  .limit(1)
                                  .get();

                          if (querySnapshot.docs.isNotEmpty) {
                            QueryDocumentSnapshot<Map<String, dynamic>>
                                documentSnapshot = querySnapshot.docs[0];
                            Map<String, dynamic> data = documentSnapshot.data();
                            BuildContext chatcontext = context;

                            Future.delayed(Duration.zero, () {
                              navigateToChat(chatcontext, data);
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                                filteredcoll[index],
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
            'We Chat',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'navigation');
              },
              icon: Icon(Icons.exit_to_app)),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      ),
    );
  }

  Future<void> update() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('colleague')
        .where('email', isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    final List<String> mycoll = querySnapshot.docs
        .map((QueryDocumentSnapshot doc) => doc.get('email') as String)
        .toList();
    ;

    setState(() {
      coll = mycoll;
      filteredcoll = mycoll;
    });
  }

  void navigateToChat(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            messenger(m: data['email'] ?? '', n: data['name'] ?? ''),
      ),
    );
  }

  void filterData(String query) {
    List<String> filteredList = coll
        .where((email) => email.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredcoll = filteredList;
    });
  }
}
