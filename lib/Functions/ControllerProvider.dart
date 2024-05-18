import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:process_run/process_run.dart';

class ControllerProvider extends ChangeNotifier {
  static TextEditingController controller = TextEditingController();
  static Shell shell = Shell(workingDirectory: "lib");
  static Shell shell2 = Shell(workingDirectory: "lib/Functions/VoiceOCR/stt");
}