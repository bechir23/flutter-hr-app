import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskDetails extends StatefulWidget {
  static const String screenroute = 'details';
  final Map<String, dynamic> m;
  final int i;
  final String d;

  const TaskDetails(
      {super.key, required this.m, required this.d, required this.i});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  int count = 0;
  Future<int> getDocumentCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('comment${widget.i}')
          .get();
      return querySnapshot.docs.length;
    } catch (error) {
      return 0;
    }
  }

  final user = FirebaseAuth.instance.currentUser!;
  final _commentcontroller = TextEditingController();
  Future Submit(String a, DateTime b, String c) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('comment${widget.i}')
        .add({'comment': a, 'time': b, 'email': c});
  }

  @override
  void initState() {
    super.initState();
    getDocumentCount().then((documentcount) {
      setState(() {
        count = documentcount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 192, 109, 137),
          title: const Text('Details',
              style: TextStyle(color: Colors.white, fontSize: 40)),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Are you sure you want to discard changes?',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('post')
                                              .doc(widget.d)
                                              .delete();
                                          Navigator.pushNamed(
                                              context, 'welcome');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text('Yes',
                                                style: TextStyle(
                                                    color: Colors.green)),
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
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text('No',
                                                style: TextStyle(
                                                    color: Colors.red)),
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
            ),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'welcome');
              },
              icon: const Icon(Icons.exit_to_app_rounded)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'email',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),

                Text(
                  widget.m['email'] ?? 'not enregistred',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const Text(
                  'task',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),

                Text(
                  widget.m['task'] ?? 'No email available',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const Text(
                  'description',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),

                Text(
                  widget.m['description'] ?? 'No email available',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const Text(
                  'start',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),

                Text(
                    '${widget.m['start']?.toDate().year}-${widget.m['start']?.toDate().month.toString().padLeft(2, '0')}-${widget.m['start']?.toDate().day.toString().padLeft(2, '0')} ${widget.m['start']?.toDate().hour.toString().padLeft(2, '0')}:${widget.m['start']?.toDate().minute.toString().padLeft(2, '0')}:${widget.m['start']?.toDate().second.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20, color: Colors.blue)),
                const Text(
                  'due',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                ),

                Text(
                    '${widget.m['due']?.toDate().year}-${widget.m['due']?.toDate().month.toString().padLeft(2, '0')}-${widget.m['due']?.toDate().day.toString().padLeft(2, '0')} ${widget.m['due']?.toDate().hour.toString().padLeft(2, '0')}:${widget.m['due']?.toDate().minute.toString().padLeft(2, '0')}:${widget.m['due']?.toDate().second.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20, color: Colors.blue)),
                const Text('priority',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic)),
                Text(
                  widget.m['priority'] ?? 'No email available',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const Divider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
                Row(children: [
                  const Icon(Icons.comment),
                  Text('$count comment(s)')
                ]),
                const Divider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
                //  Text(Provider.of<check>(context,listen: false).scale,style:const TextStyle(fontSize: 20,color: Colors.blue),),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('comment${widget.i}')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Not found'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          if (data['comment'] == null) {
                            return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
                          }
                          return Padding(
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
                                    data['email']
                                        .toString()
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                // ignore: dead_code
                                title: Text(
                                  data['comment'] ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  data['email'] ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Are you sure you want to delete?',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'comment${widget.i}')
                                                                    .doc(
                                                                        document
                                                                            .id)
                                                                    .delete();
                                                                count--;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      12.0),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      12.0),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red)),
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
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                      // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
                    },
                  ),
                )
              ]),
        ),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  textInputAction: TextInputAction.send,
                  controller: _commentcontroller,
                  decoration:
                      const InputDecoration(hintText: 'Write a comment...'),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Submit(value, DateTime.now(), user.email ?? '');
                      setState(() {
                        count++;
                        _commentcontroller.text = '';
                      });
                    }
                  },
                )),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Submit(_commentcontroller.text, DateTime.now(),
                          user.email ?? '');
                      setState(() {
                        count++;
                        _commentcontroller.text = '';
                      });
                    },
                    icon: const Icon(Icons.send))
              ],
            )),
      ),
    );
  }
}
