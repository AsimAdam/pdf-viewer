// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFViewerPage extends StatelessWidget {
  final String pdfPath;
  final String pdfFileName;

  PDFViewerPage({required this.pdfPath, required this.pdfFileName});

  Future<void> _savePDFToDevice() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    String pdfFilePath = '$appDocPath/$pdfFileName.pdf';

    if (await File(pdfFilePath).exists()) {
      // File already exists, handle accordingly
      print('File already exists: $pdfFilePath');
      return;
    }

    try {
      await File(pdfPath).copy(pdfFilePath);
      print('PDF saved successfully: $pdfFilePath');
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
            onPressed: _savePDFToDevice,
            icon: const Icon(Icons.save),
            tooltip: 'Save PDF',
          ),
        ],
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}