import 'package:flutter/material.dart';
import 'package:myapp/files/fileview.dart';
import 'package:myapp/files/folderdata.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';
import 'addemployee.dart';
import 'addorganization.dart';
import 'employeefiles.dart';
import 'organizationfiles.dart';

class AddFILE extends StatefulWidget {
  static const String screenroute = 'file';
  const AddFILE({super.key});

  @override
  State<AddFILE> createState() => _AddFILEState();
}

class _AddFILEState extends State<AddFILE> {
  int index = 0;
  final pages = [const organizationfiles(), const employeefiles()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
          height: 60,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.file_copy_rounded),
              label: 'Organization Files',
            ),
            NavigationDestination(
                icon: Icon(Icons.file_download_sharp), label: 'Employee Files'),
          ]),
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'FILES',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Provider.of<pos>(context, listen: false).index = 0;
                Navigator.pushNamed(context, 'navigation');
              })),
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<folderdata>(context, listen: false).init();
          Provider.of<fileview>(context, listen: false).init();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: index == 0
                        ? const Addorganization()
                        : const Addemployee(),
                  )));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.pink,
        ),
      ),
    );
  }
}
