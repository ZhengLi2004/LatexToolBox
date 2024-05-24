import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latext/latext.dart';
import 'package:latextb/Functions/ControllerProvider.dart';
import 'package:latextb/Functions/FormulaOCR/Refresh.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

enum mode {
  expand(0, "Expand"),
  factor(1, "Factorize"),
  simplify(2, "Simplify");

  const mode(this.num, this.label);
  final int num;
  final String label;
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final localController = TextEditingController();
  mode? selectedMode;

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
                Row(
                  children: [
                    Expanded(child: Container()),
                    DropdownMenu<mode>(
                      initialSelection: mode.simplify,
                      requestFocusOnTap: true,
                      label: const Text("Calculate Mode"),
                      onSelected: (mode? mode) {
                        setState(() {
                          selectedMode = mode;
                        });
                      },
                      dropdownMenuEntries: mode.values
                        .map<DropdownMenuEntry<mode>>((mode m) {
                          return DropdownMenuEntry<mode>(
                            value: m,
                            label: m.label,
                          );
                        }).toList(),
                    ),
                    SizedBox(width: 10.0,),
                    ElevatedButton(
                      onPressed: () async {
                        const JsonDecoder decoder = JsonDecoder();
                        String text = ControllerProvider.controller.text.replaceAll("\\", "`");

                        if (selectedMode == mode.expand) {
                          await http.post(Uri.parse('http://127.0.0.1:8000/inputCalculatorExpand/' + text));
                        }
                        else if (selectedMode == mode.factor) {
                          await http.post(Uri.parse('http://127.0.0.1:8000/inputCalculatorFactor/' + text));
                        }
                        else {
                          await http.post(Uri.parse('http://127.0.0.1:8000/inputCalculatorSimplify/' + text));
                        };

                        var response = await http.get(Uri.parse('http://127.0.0.1:8000/outputQueue'));
                        Map<String, dynamic> object = decoder.convert(response.body);

                        localController.text += object["Response"];

                        setState(() {});
                      }, 
                      child: Text("Generate")
                    ),
                    Expanded(child: Container()),
                  ],
                )
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