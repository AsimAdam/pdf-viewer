// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, library_prefixes, duplicate_import, use_key_in_widget_constructors, sized_box_for_whitespace

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pdfWid;
// import 'package:printing/printing.dart';

// class Generate extends StatefulWidget {
//   const Generate({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _PDFViewState createState() => _PDFViewState();
// }

// class _PDFViewState extends State<Generate> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar("Tips 11"),
//       body: PdfPreview(
//         build: (format) => _createPdf(
//           format,
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _createPdf(
//     PdfPageFormat format,
//   ) async {
//     final pdf = pdfWid.Document(
//       version: PdfVersion.pdf_1_4,
//       compress: true,
//     );
//     pdf.addPage(
//       pdfWid.Page(
//         pageFormat: PdfPageFormat((80 * (72.0 / 25.4)), 600,
//             marginAll: 5 * (72.0 / 25.4)),
//         build: (context) {
//           return pdfWid.SizedBox(
//             width: double.infinity,
//             child: pdfWid.FittedBox(
//                 child: pdfWid.Column(
//                     mainAxisAlignment: pdfWid.MainAxisAlignment.start,
//                     children: [
//                   pdfWid.Text("Follow",
//                       style: pdfWid.TextStyle(
//                           fontSize: 35, fontWeight: pdfWid.FontWeight.bold)),
//                   pdfWid.Container(
//                     width: 250,
//                     height: 1.5,
//                     margin: pdfWid.EdgeInsets.symmetric(vertical: 5),
//                     color: PdfColors.black,
//                   ),
//                   pdfWid.Container(
//                     width: 300,
//                     child: pdfWid.Text("#30FlutterTips",
//                         style: pdfWid.TextStyle(
//                           fontSize: 35,
//                           fontWeight: pdfWid.FontWeight.bold,
//                         ),
//                         textAlign: pdfWid.TextAlign.center,
//                         maxLines: 5),
//                   ),
//                   pdfWid.Container(
//                     width: 250,
//                     height: 1.5,
//                     margin: pdfWid.EdgeInsets.symmetric(vertical: 10),
//                     color: PdfColors.black,
//                   ),
//                   pdfWid.Text("Lakshydeep Vikram",
//                       style: pdfWid.TextStyle(
//                           fontSize: 25, fontWeight: pdfWid.FontWeight.bold)),
//                   pdfWid.Text("Follow on Medium, LinkedIn, GitHub",
//                       style: pdfWid.TextStyle(
//                           fontSize: 25, fontWeight: pdfWid.FontWeight.bold)),
//                 ])),
//           );
//         },
//       ),
//     );
//     return pdf.save();
//   }
// }

// customAppBar(String s) {}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final TextEditingController _titleController = TextEditingController();
  final quill.QuillController _paragraphController =
      quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate PDF')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: quill.QuillToolbar.basic(
                controller: _paragraphController,
                showCodeBlock: false,
                showListCheck: false,
                showIndent: false,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: quill.QuillEditor(
                        controller: _paragraphController,
                        scrollController: ScrollController(),
                        scrollable: true,
                        focusNode: FocusNode(),
                        autoFocus: false,
                        readOnly: false,
                        placeholder: 'Enter your text...',
                        expands: false,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeneratedPdfScreen(
                        title: _titleController.text,
                        paragraph: _paragraphController.document.toPlainText(),
                      ),
                    ),
                  );
                },
                child: Text('Generate PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneratedPdfScreen extends StatelessWidget {
  final String title;
  final String paragraph;

  const GeneratedPdfScreen({
    required this.title,
    required this.paragraph,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generated PDF')),
      body: Center(
        child: PdfPreview(
          build: (format) => _createPdf(format),
        ),
      ),
    );
  }

  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pdfWid.Document(
      version: PdfVersion.pdf_1_4,
      compress: true,
    );

    pdf.addPage(
      pdfWid.Page(
        pageFormat: PdfPageFormat((80 * (72.0 / 25.4)), 600,
            marginAll: 5 * (72.0 / 25.4)),
        build: (context) {
          return pdfWid.Center(
            child: pdfWid.Column(
              children: [
                pdfWid.Text(
                  title,
                  style: pdfWid.TextStyle(
                    fontSize: 35,
                    fontWeight: pdfWid.FontWeight.bold,
                  ),
                ),
                pdfWid.SizedBox(height: 10),
                pdfWid.Text(paragraph),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
