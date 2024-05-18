import 'package:flutter/material.dart';
import '../ControllerProvider.dart';
import '../FormulaOCR/Refresh.dart';
import 'package:provider/provider.dart';
import "DropzoneWidget.dart";

class VOCRPage extends StatefulWidget {
  const VOCRPage({Key? key}) : super(key: key);

  @override
  State<VOCRPage> createState() => _TOCRPageState();
}

class _TOCRPageState extends State<VOCRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Voice OCR"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: DropzoneWidget(),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ControllerProvider.controller,
              onChanged: (value) {
                Provider.of<Refresh>(context, listen:false).refresh(value);
              },
              minLines: 6,
              maxLines: 6,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
             ),
            ),
          ),
        ],
      ),
    );
  }
}