import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Company extends StatefulWidget {
  static const String screenroute = 'company';
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  final user = FirebaseAuth.instance.currentUser!;
  final _designationcontroller = TextEditingController();
  final _OrganizationNamecontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _Industrycontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _Phonecontroller = TextEditingController();
  DateTime date = DateTime.now();
  DateTime e = DateTime.now();
  Future Submit(String a, String b, String c, int d, DateTime e, String f,
      String g) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('colleague').add({
      'email': a,
      'oraganization': b,
      'industry': c,
      'phone': d,
      'date': e,
      'designation': f,
      'name': g
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 101, 142),
      body: Center(
        child: SingleChildScrollView(
            child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Company Information',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const Text(
                'Help us setup your account ',
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular((12)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      controller: _namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Name User')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((12)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _OrganizationNamecontroller,
                      decoration:
                          const InputDecoration(hintText: 'Organization name'),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((12)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _Industrycontroller,
                      decoration: const InputDecoration(hintText: 'Industry'),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((12)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _Phonecontroller,
                      decoration:
                          const InputDecoration(hintText: 'Phone Number'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((12)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _designationcontroller,
                      decoration:
                          const InputDecoration(hintText: 'Designation'),
                    )),
              ),
              const Text('Date of Joining'),
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
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  try {
                    if (formkey.currentState!.validate()) {
                      Submit(
                              user.email ?? 'not enregistred',
                              _OrganizationNamecontroller.text,
                              _Industrycontroller.text,
                              int.parse(_Phonecontroller.text),
                              e,
                              _designationcontroller.text,
                              _namecontroller.text)
                          .then((value) {
                        Navigator.pushNamed(context, 'auth');
                      });
                    }
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
                },
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular((12)),
                        color: Colors.green,
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
