import "package:flutter/material.dart";
import "DropzoneWidget.dart";
import "../ControllerProvider.dart";
import "package:provider/provider.dart";

class UpscalePage extends StatefulWidget {
  const UpscalePage({Key? key}) : super(key: key);

  @override
  State<UpscalePage> createState() => _UpscalePageState();
}

class _UpscalePageState extends State<UpscalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Image Fix"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: DropzoneWidget(),
          ),
        ],
      ),
    );
  }
}