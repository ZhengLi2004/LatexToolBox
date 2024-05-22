import 'package:flutter/material.dart';
import 'package:latextb/Animations/blur.dart';
import 'package:latextb/Animations/onHover.dart';
import 'package:latextb/Functions/Calculator/CalculatorPage.dart';
import 'package:latextb/Functions/FormulaOCR/FOCRPage.dart';
import 'package:latextb/Functions/ImageUpscaler/UpscalePage.dart';
import 'package:latextb/Functions/TableOCR/TOCRPage.dart';
import 'package:latextb/Functions/VoiceOCR/VOCRPage.dart';

class appPage extends StatelessWidget {
  const appPage({Key? key}) : super(key: key);

  @override
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
          child: OnHover(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const FOCRPage(),
                    ),
                );
              },
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 500.0, 
              width: 500.0,
              alignment: Alignment.center,
              child: const Blur(theWidth: 500.0, theHeight: 500.0, theChild: Text("Formula OCR"))
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OnHover(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const TOCRPage(),
                    ),
                );
              },
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 500.0, 
              width: 500.0,
              alignment: Alignment.center,
              child: const Blur(theWidth: 500.0, theHeight: 500.0, theChild: Text("Table OCR"))
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OnHover(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const UpscalePage(),
                    ),
                );
              },
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 500.0, 
              width: 500.0,
              alignment: Alignment.center,
              child: const Blur(theWidth: 500.0, theHeight: 500.0, theChild: Text("Image Fix"))
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OnHover(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const VOCRPage(),
                    ),
                );
              },
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 500.0, 
              width: 500.0,
              alignment: Alignment.center,
              child: const Blur(theWidth: 500.0, theHeight: 500.0, theChild: Text("Voice OCR"))
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OnHover(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const CalculatorPage(),
                    ),
                );
              },
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              height: 500.0, 
              width: 500.0,
              alignment: Alignment.center,
              child: const Blur(theWidth: 500.0, theHeight: 500.0, theChild: Text("Calculator"))
              ),
            ),
          ),
        ),
      ],
    )
  );
}