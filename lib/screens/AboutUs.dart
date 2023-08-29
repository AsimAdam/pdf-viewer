// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutUsPage extends StatelessWidget {
  Future<String> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/pdf.png', width: 100, height: 100),
            SizedBox(height: 16),
            Text(
              'Power Pro',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8),
            FutureBuilder<String>(
              future: _getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Version: ${snapshot.data}');
                } else {
                  return Text('Version 1.0');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
