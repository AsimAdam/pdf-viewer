// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pdfviewer/screens/AboutUs.dart';
import 'package:pdfviewer/screens/Collections.dart';
import 'package:pdfviewer/screens/Home.dart';

class SideDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> collections;
  final String nickName;

  const SideDrawer({required this.collections, required this.nickName});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.grey[200],
        iconTheme: IconThemeData(size: 40),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18),
        ),
      ),
      child: Drawer(
        child: Container(
          width: 100,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Tools and Options',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hi, $nickName',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.change_circle),
                title: Text('Generate PDF'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        title: '',
                        nickName: nickName,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text('Collections'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectionsPage(
                        collections: collections,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
