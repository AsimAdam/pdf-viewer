// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

// SourcePage.dart
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SourcePage extends StatelessWidget {
  final String url;

  SourcePage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              // debuggingEnabled: true,
              ),
        ),
      ),
    );
  }
}
