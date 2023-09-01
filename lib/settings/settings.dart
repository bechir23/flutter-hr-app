import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/settings/settingslist.dart';
import 'package:provider/provider.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      body: Column(children: [
        Expanded(
          child: Consumer<setwidgets>(
            builder: (context, Data, child) {
              return ListView.builder(
                  itemCount: Data.l.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(Data.l[index].name!),
                      leading: Data.l[index].icon,
                      children: <Widget>[
                        ListView.builder(
                          itemCount: Data.l[index].children?.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index1) {
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text(
                                  Data.l[index].children![index1][0],
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    Data.l[index].children![index1][1]);
                              },
                            );
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ),
        Center(
          child: GestureDetector(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((12)),
                      color: Colors.white,
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'SIGN OUT',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  )),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Are you sure you want to sign out?',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Provider.of<pos>(context, listen: false)
                                            .index = 0;

                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushNamed(context, 'auth');
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
                                              style:
                                                  TextStyle(color: Colors.red)),
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
                    ));
                  },
                );
              }),
        ),
      ]),
    );
  }
}
