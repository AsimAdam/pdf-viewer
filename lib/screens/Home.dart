// // ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, use_build_context_synchronously, depend_on_referenced_packages

// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:pdfviewer/screens/PdfViewer.dart';
// import 'package:pdfviewer/screens/SideDrawer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'dart:io';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title, this.collections = const []})
//       : super(key: key);

//   final String title;
//   final List<Map<String, dynamic>> collections;

//   @override
//   State<HomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> collections = [];
//   Future<void> _showCreateCollectionDialog() async {
//     String collectionName = '';
//     List<String> selectedPdfFileNames = [];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Create Collection'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   collectionName = value;
//                 },
//                 decoration: InputDecoration(labelText: 'Collection Name'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.custom,
//                     allowedExtensions: ['pdf'],
//                     allowMultiple: true,
//                   );
//                   if (result != null) {
//                     selectedPdfFileNames =
//                         result.files.map((file) => file.name).toList();
//                     _showConfirmationDialog(
//                         collectionName, selectedPdfFileNames);
//                   }
//                 },
//                 child: Text('Upload PDFs'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _showConfirmationDialog(
//       String collectionName, List<String> selectedPdfFileNames) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Collection Creation'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Collection Name: $collectionName'),
//               Text('Selected PDFs: ${selectedPdfFileNames.join(", ")}'),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Cancel'),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _createAndSaveCollection(
//                           collectionName, selectedPdfFileNames);
//                     },
//                     child: Text('Create'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _createAndSaveCollection(
//       String collectionName, List<String> pdfFileNames) async {
//     final newCollection = {
//       'collectionName': collectionName,
//       'pdfFileNames': pdfFileNames,
//       'creationDate': DateTime.now().toString(),
//     };

//     collections.add(newCollection);

//     final collectionsJson = json.encode(collections);

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('collections', collectionsJson);

//     // Create a directory for the collection's PDFs
//     final directory = await getApplicationDocumentsDirectory();
//     final collectionDirectory = Directory('${directory.path}/$collectionName');
//     if (!collectionDirectory.existsSync()) {
//       collectionDirectory.createSync();
//     }

//     // Move the selected PDF files to the collection directory
//     for (String pdfFileName in pdfFileNames) {
//       // Assuming the source PDF files are located in the app's documents directory
//       final pdfSourceFile = File('${directory.path}/$pdfFileName');

//       if (pdfSourceFile.existsSync()) {
//         final pdfDestinationFile =
//             File('${collectionDirectory.path}/$pdfFileName');
//         pdfSourceFile.copySync(pdfDestinationFile.path);
//       } else {
//         print('Source PDF file not found: $pdfFileName');
//       }
//     }

//     print('Collection saved: $collectionName ($pdfFileNames)');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       drawer: SideDrawer(collections: widget.collections),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     FilePickerResult? result =
//                         await FilePicker.platform.pickFiles(
//                       type: FileType.custom,
//                       allowedExtensions: ['pdf'],
//                     );

//                     if (result != null) {
//                       String pdfPath = result.files.single.path!;
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PDFViewerPage(
//                             pdfPath: pdfPath,
//                             pdfFileName: '',
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.all(16),
//                     minimumSize: Size(200, 60),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.picture_as_pdf,
//                         size: 32,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Open PDF',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showCreateCollectionDialog,
//         tooltip: 'Create Collection',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, use_build_context_synchronously, depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pdfviewer/screens/SideDrawer.dart';
import 'package:pdfviewer/screens/Generate.dart'; // Import your Generate page
import 'package:flutter_quill/flutter_quill.dart' as quill;

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
    this.collections = const [],
    required String nickName,
  })  : _nickName = nickName,
        super(key: key);

  final String title;
  final List<Map<String, dynamic>> collections;
  final String _nickName; // Store the nickname in a private variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(size: 60), // Adjust the icon size as needed
        ),
        child: SideDrawer(
          collections: collections,
          nickName: _nickName, // Pass the stored nickname
        ),
      ),
      body: GenerateContent(), // Placing the content from Generate here
    );
  }
}

class GenerateContent extends StatefulWidget {
  @override
  _GenerateContentState createState() => _GenerateContentState();
}

class _GenerateContentState extends State<GenerateContent> {
  final TextEditingController _titleController = TextEditingController();
  final quill.QuillController _paragraphController =
      quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: quill.QuillToolbar.basic(
              controller: _paragraphController,
              showCodeBlock: false,
              showListCheck: false,
              showIndent: false,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Your title here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: quill.QuillEditor(
                      controller: _paragraphController,
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: FocusNode(),
                      autoFocus: false,
                      readOnly: false,
                      placeholder: 'What do you want to write about?...',
                      expands: false,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GeneratedPdfScreen(
                      title: _titleController.text,
                      paragraph: _paragraphController.document.toPlainText(),
                    ),
                  ),
                );
              },
              child: Text('Create PDF'),
            ),
          ),
        ],
      ),
    );
  }
}
