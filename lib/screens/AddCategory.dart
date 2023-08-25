// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showAddCategoryBottomSheet(BuildContext context,
    SharedPreferences prefs, List<String> categories) async {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: categoryNameController,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String categoryName = categoryNameController.text;
                    String description = descriptionController.text;

                    if (categoryName.isNotEmpty) {
                      await saveCategoryAndPdf(prefs, categories, categoryName);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> saveCategoryAndPdf(SharedPreferences prefs,
    List<String> categories, String categoryName) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    String pdfPath = result.files.single.path!;

    List<String> pdfs = prefs.getStringList(categoryName) ?? [];
    pdfs.add(pdfPath);
    prefs.setStringList(categoryName, pdfs);

    if (!categories.contains(categoryName)) {
      categories.add(categoryName);
      prefs.setStringList('categories', categories);
    }
  }
}
