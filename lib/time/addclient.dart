import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addclient extends StatefulWidget {
  static const screenroute = 'addclient';
  const addclient({super.key});

  @override
  State<addclient> createState() => _addclientState();
}

class _addclientState extends State<addclient> {
  final _citycontroller = TextEditingController();
  final _codecontroller = TextEditingController();
  List<String> itemslist = ['QAR', 'USD', 'EUR'];
  String? selecteditem = 'QAR';
  final _emailcontroller = TextEditingController();
  final _streetcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();
  final _firstnamecontroller = TextEditingController();
  bool isLoading = false;
  final _statecontroller = TextEditingController();
  final _industrycontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _lastnamecontroller = TextEditingController();

  // final _startcontroller=TextEditingController();

// ignore: non_constant_identifier_names

  bool _isValidEmail(String input) {
    // Regular expression pattern for basic email validation
    // This is a simplified pattern and might not cover all edge cases
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(input);
  }

  bool _emailValid = true;

  Future Submit(String a, String b, String c, String f, String g, int h,
      String i, String j, int k, String l, String m, String n, String o) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('client').add({
      'name': a,
      'currency': b,
      'email': c,
      'firstname': f,
      'lastname': g,
      'phone': h,
      'street': i,
      'state': j,
      'code': k,
      'country': l,
      'industry': m,
      'description': n,
      'city': o
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
            'Add Client',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app)),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white),
            child: Form(
              key: formkey,
              child: Column(children: [
                const Text('Client Name'),
                TextFormField(
                    textAlign: TextAlign.center,
                    autofocus: true,
                    controller: _namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter client name';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
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
                        })),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Contacts',
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
                const Text('Email ID'),
                TextFormField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _emailcontroller,
                  onChanged: (input) {
                    setState(() {
                      _emailValid = _isValidEmail(input);
                    });
                  },
                ),
                if (!_emailValid)
                  const Text(
                    'Please enter a valid email',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 10,
                ),
                const Text('First Name'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _firstnamecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Last Name'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _lastnamecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Phone'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _phonecontroller,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Details',
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Description'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _descriptioncontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Industry'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _industrycontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('ZIP/PIN Code'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _codecontroller,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('State/Province'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _statecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('City'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _citycontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Street Adress'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _streetcontroller,
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
                              if (formkey.currentState!.validate()) {
                                if (_emailValid) {
                                  try {
                                    Submit(
                                      _namecontroller.text,
                                      selecteditem!,
                                      _emailcontroller.text,
                                      _firstnamecontroller.text,
                                      _lastnamecontroller.text,
                                      int.parse(_phonecontroller.text),
                                      _streetcontroller.text,
                                      _statecontroller.text,
                                      int.parse(_codecontroller.text),
                                      '',
                                      _industrycontroller.text,
                                      _descriptioncontroller.text,
                                      _citycontroller.text,
                                    ).then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    });
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                            child: AlertDialog(
                                          content: Text(
                                            'Please check Code/Phone',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ));
                                      },
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: AlertDialog(
                                        content: Text(
                                          'Please enter a valid email',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ));
                                    },
                                  );
                                }
                              } else {
                                isLoading = false;
                              }
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
