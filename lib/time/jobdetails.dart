import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class jobdetails extends StatefulWidget {
  final Map<String, dynamic> m;
  final String d;
  const jobdetails({super.key, required this.m, required this.d});

  @override
  State<jobdetails> createState() => _jobdetailsState();
}

class _jobdetailsState extends State<jobdetails> {
  bool _showAttachment = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 192, 109, 137),
        title: const Text('Details',
            style: TextStyle(color: Colors.white, fontSize: 40)),
        leading: Row(children: [
          Expanded(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'job');
                  },
                  icon: const Icon(Icons.exit_to_app_rounded))),
          const SizedBox(
            width: 30,
          ),
          //email==d['email] ? .......:container
          Expanded(
            child: IconButton(
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
                                              .collection('job')
                                              .doc(widget.d)
                                              .delete();
                                          Navigator.pushNamed(context, 'job');
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
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Job Name',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['name'] ?? 'not enregistred',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Project',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['project'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Assignees',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['assignees'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Start Date',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                  '${widget.m['start']?.toDate().year}-${widget.m['start']?.toDate().month.toString().padLeft(2, '0')}-${widget.m['start']?.toDate().day.toString().padLeft(2, '0')} ',
                  style: const TextStyle(fontSize: 20, color: Colors.blue)),
              const Text(
                'End Date',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                  '${widget.m['end']?.toDate().year}-${widget.m['end']?.toDate().month.toString().padLeft(2, '0')}-${widget.m['end']?.toDate().day.toString().padLeft(2, '0')} ',
                  style: const TextStyle(fontSize: 20, color: Colors.blue)),
              const Text(
                'File Attachment',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              GestureDetector(
                onTap: () {
                  setattachment();
                },
                child: const Text('File Attachment'),
              ),
              if (_showAttachment)
                Expanded(
                  child: getattachment(),
                ),
            ]),
      ),
    );
  }

  Widget getattachment() {
    final String? filePath = widget.m['path'];
    if (filePath != null) {
      if (filePath.endsWith('.pdf')) {
        return PDFView(
          filePath: filePath,
        );
      } else {
        return Image.file(
          File(filePath),
          height: 200,
        );
      }
    } else {
      return Container();
    }
  }

  void setattachment() {
    setState(() {
      _showAttachment = !_showAttachment;
    });
  }
}
