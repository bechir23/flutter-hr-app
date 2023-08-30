import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class organizationscreen extends StatefulWidget {
  static const screenroute = 'organization';
  const organizationscreen({super.key});

  @override
  State<organizationscreen> createState() => _organizationscreenState();
}

class _organizationscreenState extends State<organizationscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            setState(() {
              Provider.of<pos>(context, listen: false).index = 0;

              Navigator.pushNamed(context, 'navigation');
            });
          },
        ),
        title: const Text(
          'Organization',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 240, 128, 165),
      body: ListView(children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'colldept');
          },
          child: const ListTile(
            title: Text('View'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'exit');
          },
          child: const ListTile(
            title: Text('Exit details'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
      ]),
    );
  }
}
