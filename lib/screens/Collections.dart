// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    }
    setState(() {});
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
          final pdfFileNames = collection['pdfFileNames'];
          final creationDate = collection['creationDate'];

          return ListTile(
            leading: Icon(Icons.folder),
            title: Text(collectionName),
            subtitle: Text(
                'Files: ${pdfFileNames.join(", ")}\nCreated: $creationDate'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
