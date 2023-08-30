import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addmedical extends StatefulWidget {
  static const screenroute = 'addmedical';
  const addmedical({super.key});

  @override
  State<addmedical> createState() => _addmedicalState();
}

class _addmedicalState extends State<addmedical> {
  bool isLoading = false;

  final _schemecontroller = TextEditingController();
  final _categorycontroller = TextEditingController();
  final _costcontroller = TextEditingController();
  final _membercontroller = TextEditingController();
  final _numbercontroller = TextEditingController();

  Future Submit(String a, String b, int c, String d, int e) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('medical').add({
      'scheme': a,
      'category': b,
      'cost': c,
      'member': d,
      'number': e,
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
            'Medical',
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
                    int number = int.parse(_numbercontroller.text);
                    Submit(
                      _schemecontroller.text,
                      _categorycontroller.text,
                      int.parse(_costcontroller.text),
                      _membercontroller.text,
                      number,
                    ).then((value) {
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text(
                              'Phone number and cost are required',
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
                    const Text('Scheme'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _schemecontroller,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text('Category'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _categorycontroller,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Cost'),

                    TextField(
                        textAlign: TextAlign.center,
                        autofocus: true,
                        controller: _costcontroller,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ]),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Member'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _membercontroller,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Membership number'),

                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _numbercontroller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // GestureDetector(onTap: (){Navigator.pushNamed(context,'currency');},
                    //   child: const ListTile(
                    //     title: Text('Currency'),trailing: Icon(Icons.skip_next),
                    //           ),
                    //    ),
                    //    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
