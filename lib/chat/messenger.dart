import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class messenger extends StatefulWidget {
  final String m;
  final String n;
  const messenger({super.key, required this.m, required this.n});

  @override
  State<messenger> createState() => _messengerState();
}

class _messengerState extends State<messenger> {
  Future delete() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('messages')
        .where('sender', isEqualTo: user.email ?? '')
        .where('receiver', isEqualTo: widget.m)
        .get();
    QuerySnapshot querySnapshot1 = await firestore
        .collection('messages')
        .where('sender', isEqualTo: widget.m)
        .where('receiver', isEqualTo: user.email ?? '')
        .get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
    for (QueryDocumentSnapshot documentSnapshot1 in querySnapshot1.docs) {
      await documentSnapshot1.reference.delete();
    }
  }

  bool isSender(String a) {
    return (a == user.email);
  }

  final user = FirebaseAuth.instance.currentUser!;
  final _messageController = TextEditingController();
  Future SendMessage(String a, DateTime b, String c, String d) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('messages')
        .add({'message': a, 'time': b, 'sender': c, 'receiver': d});
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
            title: Text(widget.n,
                style: const TextStyle(color: Colors.white, fontSize: 40)),
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
                                    'Are you sure you want to delete chat?',
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
                                            delete();
                                            Navigator.pushNamed(
                                                context, 'navigation');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                  Navigator.pushNamed(context, 'navigation');
                },
                icon: const Icon(Icons.exit_to_app_rounded)),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time', descending: false)
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
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      if (data['message'] == null ||
                          (data['sender'] != user.email &&
                              data['sender'] != widget.m) ||
                          (data['receiver'] != user.email &&
                              data['receiver'] != widget.m)) {
                        return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
                      }
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isSender(data['sender'] ?? '')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                      Material(
                                        elevation: 5,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                        color: Colors.blue,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Text(
                                              data['message'],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )),
                                      ),
                                    ])
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Material(
                                        elevation: 5,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                        color: const Color.fromARGB(
                                            255, 151, 218, 153),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Text(
                                              data['message'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            )),
                                      ),
                                    ]));
                    }).toList(),
                  );
                  // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
                },
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: _messageController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      SendMessage(value, DateTime.now(), user.email!, widget.m);
                      _messageController.text = '';
                    }
                  },
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Aa',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none),
                )),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                    size: 26,
                  ),
                  onPressed: () {
                    if (_messageController.text != '') {
                      SendMessage(_messageController.text, DateTime.now(),
                          user.email!, widget.m);
                    }
                    _messageController.text = '';
                  },
                )
              ]),
            ),
          )),
    );
  }
}
