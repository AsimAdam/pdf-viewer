// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class PDFViewerPage extends StatelessWidget {
//   final String pdfPath;
//   final String pdfFileName;

//   PDFViewerPage(
//       {required this.pdfPath,
//       required this.pdfFileName,
//       required String filePath});

//   Future<void> _savePDFToDevice() async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;

//     String pdfFilePath = '$appDocPath/$pdfFileName.pdf';

//     if (await File(pdfFilePath).exists()) {
//       // File already exists, handle accordingly
//       print('File already exists: $pdfFilePath');
//       return;
//     }

//     try {
//       await File(pdfPath).copy(pdfFilePath);
//       print('PDF saved successfully: $pdfFilePath');
//     } catch (e) {
//       print('Error saving PDF: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF Viewer'),
//         actions: [
//           IconButton(
//             onPressed: _savePDFToDevice,
//             icon: const Icon(Icons.save),
//             tooltip: 'Save PDF',
//           ),
//         ],
//       ),
//       body: PDFView(
//         filePath: pdfPath,
//         enableSwipe: true,
//         swipeHorizontal: true,
//         autoSpacing: true,
//         pageFling: true,
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PDFViewerPage extends StatelessWidget {
  final PDFDocument document;

  PDFViewerPage({required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFViewer(
        document: document,
        zoomSteps: 1,
      ),
    );
  }
}
