// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, sort_child_properties_last, prefer_interpolation_to_compose_strings, avoid_print, sized_box_for_whitespace, unused_local_variable
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class Converter extends StatefulWidget {
//   @override
//   _ConverterState createState() => _ConverterState();
// }

// class _ConverterState extends State<Converter> {
//   final picker = ImagePicker();
//   List<File> selectedImages = [];
//   bool isImageSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image to PDF Converter"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             isImageSelected
//                 ? Container(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     child: Image.file(selectedImages.last),
//                   )
//                 : SizedBox(),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.picture_as_pdf),
//                   onPressed: selectedImages.isNotEmpty ? convertToPDF : null,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.download),
//                   onPressed: selectedImages.isNotEmpty ? savePDF : null,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: getImageFromGallery,
//       ),
//     );
//   }

//   getImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         selectedImages.add(File(pickedFile.path));
//         isImageSelected = true;
//       });
//     }
//   }

//   convertToPDF() async {
//     final pdf = pw.Document();

//     for (var img in selectedImages) {
//       final image = pw.MemoryImage(File(img.path).readAsBytesSync());

//       pdf.addPage(pw.Page(
//           pageFormat: PdfPageFormat.a4,
//           build: (pw.Context contex) {
//             return pw.Center(child: pw.Image(image));
//           }));
//     }

//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/images.pdf');
//     await file.writeAsBytes(await pdf.save());

//     Fluttertoast.showToast(msg: 'Images converted to PDF');
//   }

//   savePDF() async {
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/images.pdf');
//     if (await file.exists()) {
//       final fileBytes = await file.readAsBytes();
//       await File('${dir.path}/downloaded_images.pdf').writeAsBytes(fileBytes);

//       Fluttertoast.showToast(msg: 'PDF saved to documents');
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final picker = ImagePicker();
  List<File> selectedImages = [];
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image to PDF Converter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isImageSelected
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Image.file(selectedImages.last),
                  )
                : SizedBox(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: selectedImages.isNotEmpty ? convertToPDF : null,
                ),
                IconButton(
                  icon: Icon(Icons.download),
                  onPressed: selectedImages.isNotEmpty ? savePDF : null,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: getImageFromGallery,
      ),
    );
  }

  getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
        isImageSelected = true;
      });
    }
  }

  convertToPDF() async {
    final pdf = pw.Document();

    for (var img in selectedImages) {
      final image = pw.MemoryImage(File(img.path).readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/images.pdf');
    await file.writeAsBytes(await pdf.save());

    Fluttertoast.showToast(msg: 'Images converted to PDF');
  }

  Future<void> savePDF() async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      final dir = await getExternalStorageDirectory();
      if (dir != null) {
        final file = File('${dir.path}/images.pdf');
        if (await file.exists()) {
          final fileBytes = await file.readAsBytes();
          final downloadedFile = File('${dir.path}/downloaded_images.pdf');
          await downloadedFile.writeAsBytes(fileBytes);

          print('PDF saved to storage');
        }
      } else {
        print('Directory is null');
      }
    } else {
      print('Permission denied');
    }
  }
}
