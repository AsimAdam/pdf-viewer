// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, prefer_const_constructors_in_immutables, unused_import

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pdfviewer/screens/CollectionsDetails.dart';

// class CollectionsPage extends StatefulWidget {
//   final List<Map<String, dynamic>> collections;

//   CollectionsPage({required this.collections});
//   @override
//   _CollectionsPageState createState() => _CollectionsPageState();
// }

// class _CollectionsPageState extends State<CollectionsPage> {
//   List<Map<String, dynamic>> collections = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCollections();
//   }

//   Future<void> _fetchCollections() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final collectionsJson = prefs.getString('collections');
//     if (collectionsJson != null) {
//       final List<dynamic> decodedCollections = json.decode(collectionsJson);
//       collections = List<Map<String, dynamic>>.from(decodedCollections);
//       collections.sort((a, b) {
//         final DateTime dateA = DateTime.parse(a['creationDate']);
//         final DateTime dateB = DateTime.parse(b['creationDate']);
//         return dateB.compareTo(dateA);
//       });
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Collections'),
//       ),
//       body: ListView.builder(
//         itemCount: collections.length,
//         itemBuilder: (context, index) {
//           final collection = collections[index];
//           final collectionName = collection['collectionName'];
//           final creationDate = collection['creationDate'];

//           return Container(
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 249, 224, 253),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               leading: Icon(Icons.folder, size: 40),
//               title: Text(
//                 collectionName,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               trailing: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.purple.shade500,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   DateFormat('MMM d, y').format(DateTime.parse(creationDate)),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CollectionDetailsPage(
//                       collectionName: collectionName,
//                       pdfFileNames:
//                           List<String>.from(collection['pdfFileNames']),
//                       creationDates: [
//                         DateTime.parse(collection['creationDate'])
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdfviewer/screens/CollectionsDetails.dart';

class CollectionsPage extends StatefulWidget {
  final List<Map<String, dynamic>> collections;

  CollectionsPage({required this.collections});
  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  List<Map<String, dynamic>> collections = [];

  @override
  void initState() {
    super.initState();
    _fetchCollections();
  }

  Future<void> _fetchCollections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final collectionsJson = prefs.getString('collections');
    if (collectionsJson != null) {
      final List<dynamic> decodedCollections = json.decode(collectionsJson);
      collections = List<Map<String, dynamic>>.from(decodedCollections);
      collections.sort((a, b) {
        final DateTime dateA = DateTime.parse(a['creationDate']);
        final DateTime dateB = DateTime.parse(b['creationDate']);
        return dateB.compareTo(dateA);
      });
    }
    setState(() {});
  }

  Future<void> _showCreateCollectionDialog() async {
    String collectionName = '';
    List<String> selectedPdfFileNames = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Collection'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {
                      collectionName = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Collection Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: true,
                    );
                    if (result != null) {
                      selectedPdfFileNames =
                          result.files.map((file) => file.name).toList();
                      _showConfirmationDialog(
                          collectionName, selectedPdfFileNames);
                    }
                  },
                  icon: Icon(Icons.upload_file),
                  label: Text('Upload PDFs'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(
      String collectionName, List<String> selectedPdfFileNames) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Collection Creation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Collection Name: $collectionName'),
              Text('Selected PDFs: ${selectedPdfFileNames.join(", ")}'),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _createAndSaveCollection(
                            collectionName, selectedPdfFileNames);
                      },
                      child: Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _createAndSaveCollection(
      String collectionName, List<String> pdfFileNames) async {
    final newCollection = {
      'collectionName': collectionName,
      'pdfFileNames': pdfFileNames,
      'creationDate': DateTime.now().toString(),
    };

    collections.add(newCollection);

    final collectionsJson = json.encode(collections);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('collections', collectionsJson);

    final directory = await getApplicationDocumentsDirectory();
    final collectionDirectory = Directory('${directory.path}/$collectionName');
    if (!collectionDirectory.existsSync()) {
      collectionDirectory.createSync();
    }

    // Move the selected PDF files to the collection directory
    for (String pdfFileName in pdfFileNames) {
      // Assuming the source PDF files are located in the app's documents directory
      final pdfSourceFile = File('${directory.path}/$pdfFileName');

      if (pdfSourceFile.existsSync()) {
        final pdfDestinationFile =
            File('${collectionDirectory.path}/$pdfFileName');
        pdfSourceFile.copySync(pdfDestinationFile.path);
      } else {
        print('Source PDF file not found: $pdfFileName');
      }
    }

    print('Collection saved: $collectionName ($pdfFileNames)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collections'),
      ),
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
          final collectionName = collection['collectionName'];
          final creationDate = collection['creationDate'];

          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 224, 253),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.folder, size: 40),
              title: Text(
                collectionName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.purple.shade500,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  DateFormat('MMM d, y').format(DateTime.parse(creationDate)),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CollectionDetailsPage(
                      collectionName: collectionName,
                      pdfFileNames:
                          List<String>.from(collection['pdfFileNames']),
                      creationDates: [
                        DateTime.parse(collection['creationDate'])
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateCollectionDialog,
        tooltip: 'Create Collection',
        child: const Icon(Icons.add),
      ),
    );
  }
}
