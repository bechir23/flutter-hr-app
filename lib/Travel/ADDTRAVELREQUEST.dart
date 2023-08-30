import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addtravelrequest extends StatefulWidget {
  final int i;
  const addtravelrequest({super.key, required this.i});

  @override
  State<addtravelrequest> createState() => _addtravelrequestState();
}

class _addtravelrequestState extends State<addtravelrequest> {
  final user = FirebaseAuth.instance.currentUser!;
  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now();

//  final _emailcontroller=TextEditingController();
  final _departmentcontroller = TextEditingController();
  final _placecontroller = TextEditingController();

  final _purposecontroller = TextEditingController();

  DateTime e = DateTime.now();
  DateTime f = DateTime.now();
  bool isLoading = false;

  final _durationcontroller = TextEditingController();
  //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names

  Future Submit(String a, String b, String c, DateTime d, DateTime e,
      DateTime f, String g, String h, int i) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('travelrequest').add({
      'email': a,
      'department': b,
      'place': c,
      'time': d,
      'deperature': e,
      'arrival': f,
      'purpose': g,
      'duration': h,
      'travelid': i, //travelid lezem twali numbre of documents
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white),
          child: Column(children: [
            ListTile(
                textColor: Colors.pink,
                leading: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: const Text('Request')),

            const Text('Email'),

            Text(user.email != null ? user.email! : 'not enregistred'),
            const SizedBox(
              height: 20,
            ),

            const Text('Employee department'),

            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: _departmentcontroller,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text('Place of visit'),

            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: _placecontroller,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text('Expected date of deperature'),

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
                'Deperature',
                style: TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            const Text('Expected date of arrival'),

            Text('${date1.day}/${date1.month}/${date1.year}'),

            ElevatedButton.icon(
              onPressed: () async {
                DateTime? newDate1 = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));

                if (newDate1 == null) return;

                setState(() {
                  date1 = newDate1;
                  f = date1;
                });
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text(
                'Arrival',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Duration'),

            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: _durationcontroller,
            ),

            const SizedBox(
              height: 20,
            ),
            const Text('Purpose'),

            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: _purposecontroller,
            ),
            const SizedBox(
              height: 20,
            ),

            const Text('Travelid'),

            Text(widget.i.toString()),
            //TextField(textAlign: TextAlign.center,autofocus: true,controller: _travelidcontroller,),

            //ListTile(title: const Text('Priority'),trailing: IconButton(onPressed: ()
            //{
            //setState(() {
            //Navigator.pushNamed(context,'priority' );

            //});
            //}
            //, icon: const Icon(Icons.navigate_next)),),
            //Text(Provider.of<check>(context).scale),

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
                          //  Provider.of<traveldata>(context,listen:false).increment(_placecontroller.text, _purposecontroller.text);

                          Submit(
                                  user.email ?? 'not enregistred',
                                  _departmentcontroller.text,
                                  _placecontroller.text,
                                  date,
                                  e,
                                  f,
                                  _purposecontroller.text,
                                  _durationcontroller.text,
                                  widget.i)
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
    );
  }
}
