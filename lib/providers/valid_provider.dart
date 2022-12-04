import 'package:flutter/material.dart';

class ValidProvider extends ChangeNotifier {
  bool isValid = false;

  setValid(valid) {
    isValid = valid;
    notifyListeners();
  }
}
