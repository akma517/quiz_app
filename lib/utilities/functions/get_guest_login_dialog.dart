import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/screens/home_screen.dart';
import 'package:provider/provider.dart';

void getGuestLoginDialog(BuildContext context, double width, double height) {
  final formKey = GlobalKey<FormState>();
  String id = "";
  String password = "";
  bool isStart = false;
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        content: SizedBox(
          width: width * 0.7,
          height: height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
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
                        labelText: "ID",
                        hintText: "KICO 그룹웨어 ID를 입력해 주세요",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "ID를 입력해 주세요";
                      },
                      onSaved: (newValue) => id = newValue!,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
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
                        labelText: "Password",
                        hintText: "초기 비밀번호는 ID와 동일합니다",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password를 입력해 주세요";
                        }
                      },
                      onSaved: (newValue) => password = newValue!,
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    SizedBox(
                      height: height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: OutlinedButton(
                        onPressed: () {
                          final formKeyState = formKey.currentState!;
                          if (formKeyState.validate()) {
                            formKeyState.save();

                            Provider.of<UserProvider>(context, listen: false)
                                .login(id, password)
                                .then((isSuccess) {
                              if (isSuccess) {
                                isStart = true;
                                Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: GestureDetector(
                                        onTap: (() => Navigator.pop(context)),
                                        child: SizedBox(
                                          height: height * 0.3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Center(
                                                child: Text(
                                                  "ID 혹은 비밀번호가 틀립니다.\n다시 입력해 주세요.",
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: height * 0.018,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }
                            });
                          }
                        },
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: height * 0.018,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        insetPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      );
    },
  ).then((value) {
    if (isStart) {
      Provider.of<QuizProvider>(context, listen: false).initQuizMetas().then(
            (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  Provider.of<MenuProvider>(context, listen: false)
                      .setMenuTitle(Menu.quiz);
                  return const HomeScreen();
                },
              ),
              (route) => false,
            ),
          );
    }
  });
}
