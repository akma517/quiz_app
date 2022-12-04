import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void getLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: SpinKitFadingCircle(
          color: Colors.lightBlue.shade200,
          size: 70.0,
        ),
      );
    },
  );
}
