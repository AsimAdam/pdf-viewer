// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:pdfviewer/screens/PdfViewer.dart';
import 'package:pdfviewer/screens/SideDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, this.collections = const []})
      : super(key: key);

  final String title;
  final List<Map<String, dynamic>> collections;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Map<String, dynamic>> collections = [];
  Future<void> _showCreateCollectionDialog() async {
    String collectionName = '';
    List<String> selectedPdfFileNames = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Collection'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  collectionName = value;
                },
                decoration: InputDecoration(labelText: 'Collection Name'),
              ),
              ElevatedButton(
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
                child: Text('Upload PDFs'),
              ),
            ],
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _createAndSaveCollection(
                          collectionName, selectedPdfFileNames);
                    },
                    child: Text('Create'),
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

    print('Collection saved: $collectionName ($pdfFileNames)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: SideDrawer(collections: widget.collections),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (result != null) {
                      String pdfPath = result.files.single.path!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFViewerPage(
                            pdfPath: pdfPath,
                            pdfFileName: '',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(200, 60),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: 32,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Open PDF',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateCollectionDialog,
        tooltip: 'Create Collection',
        child: const Icon(Icons.add),
      ),
    );
  }
}
