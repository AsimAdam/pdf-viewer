// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CollectionDetailsPage extends StatelessWidget {
  final String collectionName;
  final List<String> pdfFileNames;

  CollectionDetailsPage({
    required this.collectionName,
    required this.pdfFileNames,
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

          return ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text(pdfFileName),
            onTap: () {},
          );
        },
      ),
    );
  }
}