import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../Widgets/DropzoneWidget.dart';

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