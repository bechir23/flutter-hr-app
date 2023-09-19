import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/files/fileview.dart';
import 'package:myapp/files/folderdata.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Addorganization extends StatefulWidget {
  const Addorganization({super.key});

  @override
  State<Addorganization> createState() => _AddorganizationState();
}

class _AddorganizationState extends State<Addorganization> {
  final user = FirebaseAuth.instance.currentUser!;
  DateTime date = DateTime.now();
  FilePickerResult? result;
  String? FileName;
  PlatformFile? pickedfile;
  File? fileToDisplay;
//  final _emailcontroller=TextEditingController();
  final _namecontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();
  DateTime e = DateTime.now();
  bool isLoading = false;
  // final _startcontroller=TextEditingController();
  //  final _duecontroller=TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

// ignore: non_constant_identifier_names
  Future<void> SendEmails(String a, String b, String c, String d) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('colleague').get();
    List<String> l = querySnapshot.docs
        .map((QueryDocumentSnapshot doc) => doc.get('email') as String)
        .toList();

    for (String i in l) {
      sendEmail(name: a, email: b, subject: c, message: d, recipient: i);
    }
  }

  void pickfile() async {
    try {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
          allowMultiple: false);

      if (result != null && result!.files.isNotEmpty) {
        setState(() {
          FileName = result!.files.first.path;
          pickedfile = result!.files.first;
          fileToDisplay = File(pickedfile!.path.toString());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future Submit(String a, String b, DateTime c, String d, String e) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('organization')
        .add({'name': a, 'description': b, 'valid': c, 'path': d, 'folder': e});
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
          child: Form(
            key: formkey,
            child: Column(children: [
              ListTile(
                  textColor: Colors.pink,
                  leading: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  title: const Text('Organization Files')),
              const Text('Files'),
              Center(
                  child: GestureDetector(
                      onTap: () {
                        pickfile();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 70, left: 70, top: 5, bottom: 5),
                        child: Container(
                            color: Colors.black,
                            child: const ListTile(
                              iconColor: Colors.white,
                              leading: Icon(Icons.attach_file),
                              title: Text(
                                'Add attachmets',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ))),
              if (fileToDisplay != null)
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      FileName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            FileName = null;
                            pickedfile = null;
                            fileToDisplay = null;
                          });
                        },
                        icon: Icon(Icons.delete))
                  ],
                )
              else
                const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              const Text('File Name'),
              TextFormField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter file name';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text('Description'),
              TextFormField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _descriptioncontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text('Valid Until'),
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
                  'SELECT',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text('Folder'),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, 'folder');
                      });
                    },
                    icon: const Icon(Icons.navigate_next)),
              ),
              Text(Provider.of<folderdata>(context).selected),
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
                            if (fileToDisplay != null) {
                              setState(() {
                                isLoading = true;
                              });
                              if (formkey.currentState!.validate()) {
                                SendEmails(
                                    _descriptioncontroller.text,
                                    user.email ?? '',
                                    FileName!,
                                    Provider.of<fileview>(context,
                                            listen: false)
                                        .selected);
                                // sendEmail(
                                //   name: _descriptioncontroller.text,
                                //   email: user.email ?? '',
                                //  subject: FileName!,
                                //  message: Provider.of<folderdata>(context,
                                //        listen: false)
                                //   .selected);
                                Submit(
                                        _namecontroller.text,
                                        _descriptioncontroller.text,
                                        e,
                                        fileToDisplay!.path,
                                        Provider.of<folderdata>(context,
                                                listen: false)
                                            .selected)
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pop(context);
                                });
                              } else {
                                isLoading = false;
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: AlertDialog(
                                    content: Text(
                                      'An attachment is required!',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ));
                                },
                              );
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
    );
  }

  Future<void> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String recipient,
  }) async {
    const serviceId = 'service_gk9vpok';
    const templateId = 'template_eyje9is';
    const userId = 'GEr9X-zy0J9zmfseB';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
          'user_recipient': recipient,
        },
      }),
    );
  }
}
