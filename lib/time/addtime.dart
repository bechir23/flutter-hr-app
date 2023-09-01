import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/time/projectdata.dart';
import 'package:provider/provider.dart';

class addtimelog extends StatefulWidget {
  static const String screenroute = 'addtime';
  const addtimelog({super.key});

  @override
  State<addtimelog> createState() => _addtimelogState();
}

class _addtimelogState extends State<addtimelog> {
  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now();
  DateTime f = DateTime.now();

  FilePickerResult? result;
  String? FileName;
  PlatformFile? pickedfile;
  File? fileToDisplay;

  final _workcontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();
  DateTime e = DateTime.now();
  bool isLoading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // final _startcontroller=TextEditingController();

// ignore: non_constant_identifier_names
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

  Future Submit(
      String a, String b, String c, DateTime d, String e, String g) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('timelog').add({
      'project': a,
      'job': b,
      'path': c,
      'time': d,
      'work': e,
      'description': g,
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
            'Add Time Log',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.exit_to_app)),
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
                Consumer<projectdata>(
                  builder: (context, projectData, _) {
                    return Column(
                      children: [
                        ListTile(
                          title: const Text('Project'),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'projectview');
                            },
                            icon: const Icon(Icons.navigate_next),
                          ),
                        ),
                        Text('Selected: ${projectData.selected[0]}'),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<projectdata>(
                  builder: (context, projectData, _) {
                    return Column(
                      children: [
                        ListTile(
                          title: const Text('Job'),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'jobview');
                            },
                            icon: const Icon(Icons.navigate_next),
                          ),
                        ),
                        Text('Selected: ${projectData.selected[1]}'),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Work Item'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _workcontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Date'),
                Text('${date.day}/${date.month}/${date.year}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('description'),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  controller: _descriptioncontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                if (Provider.of<projectdata>(context,
                                            listen: false)
                                        .selected[1] !=
                                    '') {
                                  Submit(
                                          Provider.of<projectdata>(context,
                                                  listen: false)
                                              .selected[0],
                                          Provider.of<projectdata>(context,
                                                  listen: false)
                                              .selected[1],
                                          fileToDisplay!.path,
                                          date,
                                          _workcontroller.text,
                                          _descriptioncontroller.text)
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  });
                                } else {
                                  isLoading = false;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: AlertDialog(
                                        content: Text(
                                          'Please choose a Job!',
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
      ),
    );
  }
}
