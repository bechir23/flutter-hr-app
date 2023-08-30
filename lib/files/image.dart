import 'dart:io';

import 'package:flutter/material.dart';

class imagepage extends StatelessWidget {
  final String filePath;
  const imagepage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Viewer'),
        ),
        body: Center(
          child: Image.file(
            File(filePath),
          ),
        ));
  }
}
