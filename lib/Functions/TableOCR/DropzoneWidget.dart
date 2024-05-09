import "package:flutter/material.dart";
import 'package:desktop_drop/desktop_drop.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:latextb/Functions/ControllerProvider.dart';
import 'package:http/http.dart' as http;
import "package:latext/latext.dart";
import 'package:latextb/Functions/FormulaOCR/Refresh.dart';

import 'dart:convert';
import 'dart:io' as io;

import 'package:provider/provider.dart';

class DropzoneWidget extends StatefulWidget {
  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  final Set<XFile> files = {};
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final colorButton = Colors.green.shade300;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: buildFiles(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 140,
              color: isHovering ? Colors.blue : Colors.green,
              padding: const EdgeInsets.all(8),
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.white,
                padding: EdgeInsets.zero,
                child: DropTarget(
              onDragEntered: (detail) async {
                setState(() {
                  isHovering = true;
                });
              },
              onDragExited: (detail) {
                setState(() {
                  isHovering = false;
                });
              },
              onDragDone: (detail) async {
                setState(() {
                  files.clear();
                  files.addAll(detail.files);
                });
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload,
                      size: 40,
                      color: Colors.white,
                    ),
                    const Text(
                      "Drop files or images here",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: colorButton,
                      ),
                      icon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                      label: const Text(
                        "Choose Files or Images",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                        );
            
                        if (result != null) {
                          setState(() {
                            files.clear();
                            files.addAll(result.xFiles);
                            check();
                          });
                        }; 
                      },
                    )
                  ],
                ),
              )
            ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFiles() {
    if (files.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: files.map(buildFile).toList(),
        ),
      );
    }
    else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.49,
        height: MediaQuery.of(context).size.height * 0.25,
        color: Colors.blue.shade300,
        child: const Text(
          "No Picture Processing",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Widget buildFile(XFile file) {
    return Image.file(
      io.File(file.path),
      width: MediaQuery.of(context).size.width * 0.49,
      fit: BoxFit.fitWidth,
    );
  }
    
  void check() async {
    const JsonDecoder decoder = JsonDecoder();
    Map<String, dynamic> object;

    for (var file in files) {
      var path = file.path.replaceAll('\\', '+');
      await http.post(Uri.parse('http://127.0.0.1:8000/inputTable/' + path));
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/outputQueue'));
      object = decoder.convert(response.body);

      ControllerProvider.controller.text += object["Response"];

      Provider.of<Refresh>(context, listen:false).refresh(ControllerProvider.controller.text);
    }
  }
}