import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class CompensationScreen extends StatefulWidget {
  static const String screenroute = 'compensation';
  const CompensationScreen({super.key});

  @override
  State<CompensationScreen> createState() => _CompensationScreenState();
}

class _CompensationScreenState extends State<CompensationScreen> {
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
          'Compensation',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 240, 128, 165),
      body: ListView(children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'asset');
          },
          child: const ListTile(
            title: Text('Asset'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'benefit');
          },
          child: const ListTile(
            title: Text('Benefit'),
            trailing: Icon(Icons.skip_next),
          ),
        ),
      ]),
    );
  }
}
