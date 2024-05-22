import 'package:flutter/material.dart';
import 'package:latext/latext.dart';
import 'package:latextb/Functions/ControllerProvider.dart';
import 'package:latextb/Functions/FormulaOCR/Refresh.dart';
import 'package:provider/provider.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final localController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calculator"),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.49,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.49,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: SingleChildScrollView(
                    child: Builder(
                    builder: (context) {
                      String text = Provider.of<Refresh>(context).code;
                      String context1 = "\$\$" + text + "\$\$";
                      return LaTexT(laTeXCode: Text(context1, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red)), breakDelimiter: "\t",);
                    }),
                  ),
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
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width*0.49,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.49,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: SingleChildScrollView(
                    child: Builder(
                    builder: (context) {
                      String text = localController.text;
                      String context1 = "\$\$" + text + "\$\$";
                      return LaTexT(laTeXCode: Text(context1, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red)), breakDelimiter: "\t",);
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: localController,
                    onChanged: (value) {
                      setState(() {});
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
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}