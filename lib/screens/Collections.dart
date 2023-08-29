// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, prefer_const_constructors_in_immutables, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print, deprecated_member_use

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
  List<String> selectedPdfFilePath = [];

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
    String collectionFiles = '';
    List<String> selectedPdfFileNames = [];
    List<dynamic> selectedPdfFilePath = [];

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
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      onPrimary: Color.fromARGB(255, 249, 224, 253)),
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
                      selectedPdfFilePath =
                          result.files.map((file) => file.path).toList();
                      print('path: ${selectedPdfFilePath[0]}');
                      _showConfirmationDialog(
                          collectionName,
                          selectedPdfFileNames,
                          collectionFiles,
                          selectedPdfFilePath);
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
      String collectionName,
      List<String> selectedPdfFileNames,
      String collectionFiles,
      List selectedPdfFilePath) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to proceed?'),
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
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 249, 224, 253),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        onPrimary: Color.fromARGB(255, 249, 224, 253),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _createAndSaveCollection(
                          collectionName,
                          selectedPdfFileNames,
                          collectionFiles,
                          List<String>.from(selectedPdfFilePath),
                        );
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
      String collectionName,
      List<String> pdfFileNames,
      String collectionFiles,
      List<String> selectedPdfFilePath) async {
    final newCollection = {
      'collectionName': collectionName,
      'collectionFiles': collectionFiles,
      'pdfFileNames': pdfFileNames,
      'creationDate': DateTime.now().toString(),
    };

    collections.add(newCollection);

    collections.sort((a, b) {
      final DateTime dateA = DateTime.parse(a['creationDate']);
      final DateTime dateB = DateTime.parse(b['creationDate']);
      return dateB.compareTo(dateA);
    });

    final collectionsJson = json.encode(collections);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('collections', collectionsJson);

    final directory = await getApplicationDocumentsDirectory();
    final collectionDirectoryName =
        '$collectionName, ${pdfFileNames.join(", ")}';
    final collectionDirectory =
        Directory('${directory.path}/$collectionDirectoryName');
    if (!collectionDirectory.existsSync()) {
      collectionDirectory.createSync();
    }

    for (int i = 0; i < pdfFileNames.length; i++) {
      final pdfSourceFile = File(selectedPdfFilePath[i]);

      if (pdfSourceFile.existsSync()) {
        final pdfDestinationFile =
            File('${collectionDirectory.path}/${pdfFileNames[i]}');
        pdfSourceFile.copySync(pdfDestinationFile.path);
      } else {
        print('Source PDF file not found: ${selectedPdfFilePath[i]}');
      }
    }

    setState(() {
      collections = List<Map<String, dynamic>>.from(collections);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collections',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: collections.isEmpty
          ? Center(
              child: Text(
                "You don't have any collections yet.\nPress the ⊕ button to create collections.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            )
          : RefreshIndicator(
              onRefresh: _fetchCollections,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final collection = collections[index];
                        final collectionName = collection['collectionName'];
                        final creationDate = collection['creationDate'];

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: Icon(
                              Icons.folder,
                              size: 50,
                              color: Color.fromARGB(255, 249, 224, 253),
                            ),
                            title: Text(
                              collectionName,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 249, 224, 253)),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 249, 224, 253),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                DateFormat('MMM d, y')
                                    .format(DateTime.parse(creationDate)),
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CollectionDetailsPage(
                                    collectionName: collectionName,
                                    pdfFileNames: List<String>.from(
                                        collection['pdfFileNames']),
                                    creationDates: [
                                      DateTime.parse(collection['creationDate'])
                                    ],
                                    collectionFiles: '',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      childCount: collections.length,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Color.fromARGB(255, 249, 224, 253),
        onPressed: _showCreateCollectionDialog,
        tooltip: 'Create Collection',
        child: const Icon(Icons.add),
      ),
    );
  }
}
