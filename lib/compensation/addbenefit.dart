import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'medical.dart';

class addbenefit extends StatefulWidget {
  const addbenefit({super.key});

  @override
  State<addbenefit> createState() => _addbenefitState();
}

class _addbenefitState extends State<addbenefit> {
  List<String> itemslist = ['QAR', 'USD', 'EUR'];
  String? selecteditem = 'QAR';

  final user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;

  final _housingcontroller = TextEditingController();

  final _lunchcontroller = TextEditingController();

  final _educationcontroller = TextEditingController();

// ignore: non_constant_identifier_names

  Future clearCollection() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('medical');

    QuerySnapshot snapshot = await collectionRef.get();

    // Create a batch operation to delete all documents
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    // Commit the batch operation
    await batch.commit();
  }

  Future Submit(String a, String b, String c, String d, String e) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('tabbenefit').add(
        {'email': a, 'education': b, 'lunch': c, 'housing': d, 'currency': e});
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color.fromARGB(255, 223, 130, 161),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    textColor: Colors.pink,
                    leading: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    title: const Text('Benefit')),
                const Text('Email'),
                Text(user.email != null ? user.email! : 'not enregistred'),
                const SizedBox(
                  height: 20,
                ),
                const Text('Education Allowance'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _educationcontroller,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Lunch'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _lunchcontroller,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Housing Allowance'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _housingcontroller,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Currency'),
                DropdownButton<String>(
                    value: selecteditem,
                    items: itemslist
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ))
                        .toList(),
                    onChanged: (item) => setState(() {
                          selecteditem = item;
                          Provider.of<medicaldata>(context, listen: false)
                              .update(selecteditem!);
                        })),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'addmedical');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((12)),
                          color: const Color.fromARGB(255, 54, 82, 244),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add Medical'),
                            SizedBox(width: 20),
                            Icon(Icons.add)
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  //55214495
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('medical')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(child: Text('No Trips found'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                Provider.of<medicaldata>(context, listen: false)
                                    .documents
                                    .add(data);
                                if (data['scheme'] == null) {
                                  return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 204, 101, 178),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(children: [
                                        Row(children: [
                                          data['scheme'] == ''
                                              ? const Text(
                                                  '-,',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  '${data['scheme']},',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                          data['category'] == ''
                                              ? const Text(
                                                  '-,',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  '${data['category']},',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                          Text(
                                            '${data['cost']},',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          data['member'] == ''
                                              ? const Text(
                                                  '-,',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  '${data['member']},',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                          Text(
                                            '${data['number']},',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ]),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('medical')
                                                  .doc(document.id)
                                                  .delete();
                                              Provider.of<medicaldata>(context,
                                                      listen: false)
                                                  .documents
                                                  .remove(data);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ])),
                                );
                              }).toList(),
                            ),
                          );
                          // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
                        },
                      ),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<medicaldata>(context, listen: false).init();
                        clearCollection();
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular((12)),
                              color: Colors.red,
                            ),
                            child: const Center(
                                child: Text(
                              'cancel',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });

                              Submit(
                                      user.email ?? 'not enregistred',
                                      _educationcontroller.text,
                                      _lunchcontroller.text,
                                      _housingcontroller.text,
                                      Provider.of<medicaldata>(context,
                                              listen: false)
                                          .currency)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                              //    Provider.of<medicaldata>(context,listen: false).init();
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((12)),
                                    color: Colors.green,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'submit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )),
                                )),
                          ),
                        ),
                ]),
              ],
            )),
      )),
    );
  }
}
