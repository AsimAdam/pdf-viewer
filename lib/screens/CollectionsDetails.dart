// // ignore_for_file: prefer_const_constructors, prefer_const_declarations, use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class CollectionDetailsPage extends StatelessWidget {
//   final String collectionName;
//   final List<String> pdfFileNames;

//   // ignore: prefer_const_constructors_in_immutables
//   CollectionDetailsPage({
//     required this.collectionName,
//     required this.pdfFileNames,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(collectionName),
//       ),
//       body: ListView.builder(
//         itemCount: pdfFileNames.length,
//         itemBuilder: (context, index) {
//           final pdfFileName = pdfFileNames[index];

//           return ListTile(
//             leading: Icon(Icons.picture_as_pdf),
//             title: Text(pdfFileName),
//             onTap: () async {
//               // Construct the PDF path based on the collection directory and file name
//               final pdfPath = '${collectionDirectory.path}/$pdfFileName';

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, prefer_const_constructors, prefer_const_declarations, unused_local_variable, file_names, avoid_print, depend_on_referenced_packages

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PDFView(
//                     filePath: pdfPath,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class CollectionDetailsPage extends StatelessWidget {
//   final String collectionName;
//   final List<String> pdfFileNames;
//   final List<DateTime> creationDates;

//   CollectionDetailsPage({
//     required this.collectionName,
//     required this.pdfFileNames,
//     required this.creationDates,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(collectionName),
//       ),
//       body: ListView.builder(
//         itemCount: pdfFileNames.length,
//         itemBuilder: (context, index) {
//           final pdfFileName = pdfFileNames[index];

//           final maxLength = 25;
//           final truncatedFileName = pdfFileName.length > maxLength
//               ? '${pdfFileName.substring(0, maxLength - 3)}...'
//               : pdfFileName;

//           return Card(
//             margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               leading: Icon(Icons.picture_as_pdf, size: 40),
//               title: Text(
//                 truncatedFileName,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               trailing: IconButton(
//                 icon: Icon(Icons.remove_red_eye, size: 30),
//                 onPressed: () async {
//                   final collectionDirectory =
//                       await getApplicationDocumentsDirectory();

//                   final pdfPath = '${collectionDirectory.path}/$pdfFileName';
//                   print('PDF Path: $pdfPath');
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PDFView(
//                         filePath: pdfPath,
//                         enableSwipe: true,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as p;

class CollectionDetailsPage extends StatelessWidget {
  final String collectionName;
  final List<String> pdfFileNames;
  final List<DateTime> creationDates;
  final String collectionFiles;

  CollectionDetailsPage({
    required this.collectionName,
    required this.pdfFileNames,
    required this.creationDates,
    required this.collectionFiles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collectionName),
      ),
      body: ListView.builder(
        itemCount: pdfFileNames.length,
        itemBuilder: (context, index) {
          final pdfFileName = pdfFileNames[index];

          final maxLength = 25;
          final truncatedFileName = pdfFileName.length > maxLength
              ? '${pdfFileName.substring(0, maxLength - 3)}...'
              : pdfFileName;

          return Card(
            color: Colors.deepPurple,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                Icons.picture_as_pdf,
                size: 40,
                color: Color.fromARGB(255, 249, 224, 253),
              ),
              title: Text(
                truncatedFileName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 249, 224, 253),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  size: 30,
                  color: Color.fromARGB(255, 249, 224, 253),
                ),
                onPressed: () async {
                  final collectionDirectory =
                      await getApplicationDocumentsDirectory();
                  final pdfPath = p.join(collectionDirectory.path, pdfFileName);
                  final pdfFile = File(pdfPath);
                  final pdfExists = await pdfFile.exists();

                  if (pdfExists) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFViewerScreen(pdfPath: pdfPath),
                      ),
                    );
                  } else {
                    print('PDF file does not exist at: $pdfPath');
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewerScreen(pdfPath: pdfPath),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  PDFViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    print('PDF Path: $pdfPath');
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}
