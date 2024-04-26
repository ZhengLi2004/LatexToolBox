import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:latextb/Functions/FormulaOCR/ControllerProvider.dart';
import 'package:provider/provider.dart';
import 'ControllerProvider.dart';

import 'DropzoneWidget.dart';

class FOCRPage extends StatefulWidget {
  const FOCRPage({Key? key}) : super(key: key);

  @override
  State<FOCRPage> createState() => _FOCRPageState();
}

class _FOCRPageState extends State<FOCRPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ControllerProvider.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("Formula OCR"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
          alignment: Alignment.center,
          padding:EdgeInsets.all(8.0),
          child: DropzoneWidget(),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: ControllerProvider.controller,
              minLines: 3,
              maxLines: 3,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
              border: OutlineInputBorder()
             ),
            ),
          ),
        ],
      ),
    );
  }
}