// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, prefer_typing_uninitialized_variables, unused_import, prefer_const_constructors_in_immutables, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:pdfviewer/screens/Collections.dart';
import 'package:pdfviewer/screens/Converter.dart';

class SideDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> collections;

  SideDrawer({required this.collections});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 50,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Tools and Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.change_circle),
              title: Text('Convert'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Converter(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.collections),
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
              leading: Icon(Icons.security),
              title: Text('Protect'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
