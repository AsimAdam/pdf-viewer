// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PrivacyPolicy extends StatelessWidget {
  final String privacyPolicyUrl = 'https://fluttergems.dev/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(privacyPolicyUrl)),
      ),
    );
  }
}
