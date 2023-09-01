import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addexpenser extends StatefulWidget {
  static const screenroute = 'addexpense';
  const addexpenser({super.key});

  @override
  State<addexpenser> createState() => _addexpenserState();
}

class _addexpenserState extends State<addexpenser> {
  bool isLoading = false;

  final _descriptioncontroller = TextEditingController();
  final _Ticketcontroller = TextEditingController();
  final _Lodgingcontroller = TextEditingController();
  final _Boardingcontroller = TextEditingController();
  final _Phonecontroller = TextEditingController();
  final _Localconveyancecontroller = TextEditingController();
  final _Incidentalscontroller = TextEditingController();
  final _Otherscontroller = TextEditingController();
  DateTime date = DateTime.now();
  DateTime e = DateTime.now();
  Future Submit(String a, DateTime b, String c, String d, String e, int f,
      String g, String h, String i) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('SET').add({
      'description': a,
      'date': b,
      'ticket': c,
      'lodging': d,
      'boarding': e,
      'phone': f,
      'local': g,
      'incidentals': h,
      'others': i,
      'time': date,
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
            'Expense',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
            icon: const Icon(
              Icons.cancel,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  try {
                    Submit(
                            _descriptioncontroller.text,
                            e,
                            _Ticketcontroller.text,
                            _Lodgingcontroller.text,
                            _Boardingcontroller.text,
                            int.parse(_Phonecontroller.text),
                            _Localconveyancecontroller.text,
                            _Incidentalscontroller.text,
                            _Otherscontroller.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text(
                              'Phone number is required',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        });
                  }
                }
                //  Submit(_schemecontroller.text,_categorycontroller.text,_costcontroller.text,_membercontroller.text,int.parse(_numbercontroller.text)  ).then((value){Navigator.pop(context);});}
                ,
                icon: const Icon(Icons.done))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 223, 130, 161),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('DESCRIPTION'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _descriptioncontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text('DATE'),

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
                        'Date',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text('TICKET'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Ticketcontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text('LODGING'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Lodgingcontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text('BOARDING'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Boardingcontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text('PHONE'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Phonecontroller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text('LOCAL CONVEYANCE'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Localconveyancecontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text('INCIDENTALS'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Incidentalscontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text('OTHERS'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _Otherscontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //ListTile(title: const Text('Priority'),trailing: IconButton(onPressed: ()
                    //{
                    //setState(() {
                    //Navigator.pushNamed(context,'priority' );

                    //});
                    //}
                    //, icon: const Icon(Icons.navigate_next)),),
                    //Text(Provider.of<check>(context).scale),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
