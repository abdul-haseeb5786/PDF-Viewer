import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PDFHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PDFHome extends StatefulWidget {
  @override
  _PDFHomeState createState() => _PDFHomeState();
}

class _PDFHomeState extends State<PDFHome> {
  File? pickedPDF;

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        pickedPDF = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer App'),
      ),
      body: pickedPDF == null
          ? Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.picture_as_pdf),
                label: Text('Pick PDF'),
                onPressed: _pickPDF,
              ),
            )
          : SfPdfViewer.file(pickedPDF!),
    );
  }
}
