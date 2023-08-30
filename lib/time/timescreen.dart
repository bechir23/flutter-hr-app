import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class timescreen extends StatefulWidget {
  static const String screenroute = 'time';
  const timescreen({super.key});

  @override
  State<timescreen> createState() => _timescreenState();
}

class _timescreenState extends State<timescreen> {
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
          'Time Tracker',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 240, 128, 165),
      body: ListView(children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'timelog');
          },
          child: const ListTile(
            title: Text('Time Logs'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'job');
          },
          child: const ListTile(
            title: Text('Jobs'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'project');
          },
          child: const ListTile(
            title: Text('Projects'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'client');
          },
          child: const ListTile(
            title: Text('Clients'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
      ]),
    );
  }
}
