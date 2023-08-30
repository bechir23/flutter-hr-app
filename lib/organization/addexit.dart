import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addexit extends StatefulWidget {
  static const screenroute = 'addexit';
  const addexit({super.key});

  @override
  State<addexit> createState() => _addexitState();
}

class _addexitState extends State<addexit> {
  final user = FirebaseAuth.instance.currentUser!;
  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now();
  final _reasoncontroller = TextEditingController();
  final _vehiculecontroller = TextEditingController();
  final _bookscontroller = TextEditingController();
  final _interviewcontroller = TextEditingController();
  final _equipmentscontroller = TextEditingController();
  final _securitycontroller = TextEditingController();
  final _noticecontroller = TextEditingController();
  final _managercontroller = TextEditingController();

  DateTime e = DateTime.now();
  DateTime f = DateTime.now();
  bool isLoading = false;

  final _lettercontroller = TextEditingController();
  //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names
  Future Submit(String a, DateTime b, String c, String d, String e, String f,
      String g, String h, String i, String j, String k) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('exit').add({
      'email': a,
      'separationdate': b,
      'reason': c,
      'vehicule': d,
      'books': e,
      'interview': f,
      'letter': g,
      'equipments': h,
      'security': i,
      'notice': j,
      'manager': k
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
          title: const Text(
            'Exit',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app)),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  'Separation',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const Text('Employee'),
                Text(user.email != null ? user.email! : 'not enregistred'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Separation Date'),
                Text('${date.day}/${date.month}/${date.year}'),
                ElevatedButton.icon(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));

                    if (newDate == null) return;

                    setState(() {
                      date = newDate;
                      e = date;
                    });
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text(
                    'Separation',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Reason for living Name'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _reasoncontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Checklist for exit inter...',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const Text('Company Vehicule handed in'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _vehiculecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('All library books submitted'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _bookscontroller,
                ),
                const Text('Interview'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _interviewcontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Resignation letter submitted'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _lettercontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('All equipments handed in'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _equipmentscontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Security'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _securitycontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Notice period followed'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _noticecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Manager/Supervisor clearance'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _managercontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                                      e,
                                      _reasoncontroller.text,
                                      _vehiculecontroller.text,
                                      _bookscontroller.text,
                                      _interviewcontroller.text,
                                      _lettercontroller.text,
                                      _equipmentscontroller.text,
                                      _securitycontroller.text,
                                      _noticecontroller.text,
                                      _managercontroller.text)
                                  .then((value) {
                                Navigator.pop(context);
                              });
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
                ])
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
