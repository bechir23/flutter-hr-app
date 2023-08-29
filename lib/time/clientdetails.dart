import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class clientdetails extends StatefulWidget {
  final Map<String, dynamic> m;
  final String d;
  const clientdetails({super.key, required this.m, required this.d});

  @override
  State<clientdetails> createState() => _clientdetailsState();
}

class _clientdetailsState extends State<clientdetails> {
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
                    Navigator.pushNamed(context, 'client');
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
                                              .collection('client')
                                              .doc(widget.d)
                                              .delete();
                                          Navigator.pushNamed(
                                              context, 'client');
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
                'Client Name',
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
                'Currency',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['currency'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Description',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['description'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'First Name',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['firstname'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Last Name',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['lasetname'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'phone',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['phone'].toString(),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Street',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['street'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'State',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['state'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'City',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['city'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Code',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['code'].toString(),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const Text(
                'Industry',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.m['industry'] ?? 'No email available',
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ]),
      ),
    );
  }
}
