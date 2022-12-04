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
                          hintText: "현재비밀번호를 입력해 주세요",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "현재비밀번호를 입력해 주세요";
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
                          hintText: "새로운 비밀번호를 입력해 주세요",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "새로운 비밀번호를 입력해 주세요";
                          if (value == password) return "기존 비밀번호와 동일할 수 없습니다";
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
                          hintText: "확인을 위해 새로운 비밀번호를 다시 입력해 주세요",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "확인을 위해 새로운 비밀번호를 입력해 주세요";
                          }
                          if (value != newPassword) {
                            return "새로운 비밀번호와 일치하지 않습니다.";
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
                                              "비밀번호가 변경되었습니다.",
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
                                              "입력하신 기존 비밀번호가 틀립니다.\n다시 입력해 주세요.",
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
                          },
                        );
                      }
                    },
                    child: Text(
                      "비밀번호 변경",
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
