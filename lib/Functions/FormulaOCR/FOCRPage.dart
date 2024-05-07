import 'package:flutter/material.dart';
import 'package:latextb/Functions/FormulaOCR/ControllerProvider.dart';
import 'package:provider/provider.dart';
import "Refresh.dart";
import 'DropzoneWidget.dart';

class FOCRPage extends StatefulWidget {
  const FOCRPage({Key? key}) : super(key: key);

  @override
  State<FOCRPage> createState() => _FOCRPageState();
}

class _FOCRPageState extends State<FOCRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Formula OCR"),
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
              minLines: 3,
              maxLines: 3,
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