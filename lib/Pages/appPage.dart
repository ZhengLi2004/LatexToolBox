import 'package:flutter/material.dart';
import 'package:latextb/Animations/blur.dart';

class appPage extends StatelessWidget {
  const appPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Application"),
      backgroundColor: Colors.green,
    ),
    body: GridView.count(
      crossAxisCount: 8,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
            height: 500.0, 
            width: 500.0,
            alignment: Alignment.center,
            child: const Blur(theWidth: 500.0, theHeight: 500.0, theChild: Text("Hello, World!"))
            ),
        ),
      ],
    )
  );
}