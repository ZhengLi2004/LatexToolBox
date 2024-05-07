import 'package:flutter/material.dart';

class Refresh with ChangeNotifier {
  String _code = "";
  String get code => _code;

  void refresh(String code) {
    _code = code;
    notifyListeners();
  }
}