// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/screens/CollectionsDetails.dart';

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
              color: Colors.grey.shade200,
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
                  color: Colors.grey.shade400,
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
                      pdfFileNames: [],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
