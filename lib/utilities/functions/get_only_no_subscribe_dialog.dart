import 'package:flutter/material.dart';

Future<dynamic> getOnlyNoSubscribeDialog(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  double height = screenSize.height;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: ((context) {
      return AlertDialog(
        content: SizedBox(
          height: height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "유효한 구독이 있을 경우 구독할 수 없습니다.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              SizedBox(
                height: height * 0.06,
                width: MediaQuery.of(context).size.width * 0.3,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: height * 0.018,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}
