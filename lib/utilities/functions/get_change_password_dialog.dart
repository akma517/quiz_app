import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:provider/provider.dart';

void getChangePasswordDialog(
    BuildContext context, double width, double height) {
  final formKey = GlobalKey<FormState>();
  String password = "";
  String newPassword = "";

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        content: SizedBox(
          width: width * 0.7,
          height: height * 0.55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          hintStyle: TextStyle(fontSize: 11),
                          labelText: "Password",
                          hintText: "????????????????????? ????????? ?????????",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "????????????????????? ????????? ?????????";
                          password = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          hintStyle: TextStyle(fontSize: 11),
                          labelText: "New",
                          hintText: "????????? ??????????????? ????????? ?????????",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "????????? ??????????????? ????????? ?????????";
                          if (value == password) return "?????? ??????????????? ????????? ??? ????????????";
                          newPassword = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          labelText: "Confirm",
                          hintStyle: TextStyle(fontSize: 11),
                          hintText: "????????? ?????? ????????? ??????????????? ?????? ????????? ?????????",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "????????? ?????? ????????? ??????????????? ????????? ?????????";
                          }
                          if (value != newPassword) {
                            return "????????? ??????????????? ???????????? ????????????.";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: SizedBox(
                  height: height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: OutlinedButton(
                    onPressed: () {
                      final formKeyState = formKey.currentState!;
                      if (formKeyState.validate()) {
                        Provider.of<UserProvider>(context, listen: false)
                            .changeUserPassword(password, newPassword)
                            .then(
                          (isSuccess) {
                            if (isSuccess) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: height * 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "??????????????? ?????????????????????.",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.06,
                                          ),
                                          SizedBox(
                                            height: height * 0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "??????",
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
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: height * 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "???????????? ?????? ??????????????? ????????????.\n?????? ????????? ?????????.",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.06,
                                          ),
                                          SizedBox(
                                            height: height * 0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "??????",
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
                          },
                        );
                      }
                    },
                    child: Text(
                      "???????????? ??????",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: height * 0.018,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        insetPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      );
    },
  );
}
