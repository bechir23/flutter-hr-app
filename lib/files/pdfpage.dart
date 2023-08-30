import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Pdfpage extends StatelessWidget {
  final String filePath;
  const Pdfpage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Viewer'),
      ),
      body: PDFView(filePath: filePath),
    );
  }
}
