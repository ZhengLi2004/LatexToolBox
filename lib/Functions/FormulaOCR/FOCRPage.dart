import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latextb/Functions/ControllerProvider.dart';
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
              minLines: 5,
              maxLines: 5,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
             ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () async {
                  Clipboard.setData(ClipboardData(text: ControllerProvider.controller.text));
                }, 
                child: Text("Copy")
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () async {
                  ClipboardData? data =
                    await Clipboard.getData(Clipboard.kTextPlain);
                    if (data != null) {
                      ControllerProvider.controller.text = data.text as String;
                      Provider.of<Refresh>(context, listen:false).refresh(data.text as String);
                    }
                }, 
                child: Text("Paste")
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () async {
                  ControllerProvider.controller.text = "";
                  Provider.of<Refresh>(context, listen:false).refresh("");
                }, 
                child: Text("Clear")
              ),
            ],
          ),
        ],
      ),
    );
  }
}