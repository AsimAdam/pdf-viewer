// ignore_for_file: file_names

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfWid;

class ContentPage extends pdfWid.StatelessWidget {
  final String title;
  final String hashtag;
  final String author;
  final String followText;
  // final pdfWid.ImageProvider imageProvider;

  ContentPage({
    required this.title,
    required this.hashtag,
    required this.author,
    required this.followText,
    // required this.imageProvider,
  });

  @override
  pdfWid.Widget build(pdfWid.Context context) {
    return pdfWid.Column(
      children: [
        pdfWid.Text(
          title,
          style: pdfWid.TextStyle(
            fontSize: 35,
            fontWeight: pdfWid.FontWeight.bold,
          ),
        ),
        pdfWid.Text(hashtag),
        pdfWid.Text(author),
        pdfWid.Text(followText),
        // pdfWid.Image(imageProvider),
      ],
    );
  }
}
