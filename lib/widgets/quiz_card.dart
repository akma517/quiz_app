import 'package:flutter/material.dart';
import 'package:hus_quiz/models/quiz_meta.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_plain_service_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_user_service_dialog.dart';
import 'package:provider/provider.dart';

import '../screens/quiz_screen.dart';
import '../providers/quiz_provider.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    Key? key,
    required this.height,
    required this.quizMeta,
  }) : super(key: key);

  final double height;
  final QuizMeta quizMeta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: height * 0.6,
      child: SizedBox(
        height: height * 0.45,
        child: Card(
          color: Colors.blue.shade100,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: SizedBox(
                    width: height * 0.2,
                    height: height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(quizMeta.imagePath),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                quizMeta.quizName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        color: Colors.orange,
                        child: TextButton(
                          onPressed: () {
                            if (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user
                                    .auth <
                                1) {
                              getOnlyUserServiceDialog(context);
                            } else if (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user
                                    .auth <
                                2) {
                              getOnlyPlainServiceDialog(context);
                            } else {
                              var confirm = false;
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text(
                                      "????????????",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    content: SizedBox(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            "1. ??????????????? ?????? ??????????????? ???????????? ???????????????.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: height * 0.02,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            "2. ??????????????? ${quizMeta.testTime}????????????.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: height * 0.02,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            "3. ??????????????? ${quizMeta.testQuestionCount}???????????????.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: height * 0.02,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            quizMeta.zeroScoreYn == 'Y'
                                                ? "4. ????????? ???????????? ?????? ${quizMeta.questionScoreCounts.split(',')[0]}????????? 0?????? ???????????????."
                                                : "4. ????????? ???????????????.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: height * 0.02,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            "5. ????????? ${quizMeta.totalScore}????????? ??????????????? ${quizMeta.passScore}??? ???????????????.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: height * 0.02,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: height * 0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    confirm = true;
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("??????",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("??????",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    insetPadding: const EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                  );
                                },
                              ).then(
                                (value) {
                                  if (confirm) {
                                    getLoadingDialog(context);
                                    Provider.of<QuizProvider>(context,
                                            listen: false)
                                        .quizMode = QuizMode.test;
                                    Provider.of<QuizProvider>(context,
                                            listen: false)
                                        .currentQuizMeta = quizMeta;
                                    Provider.of<QuizProvider>(context,
                                            listen: false)
                                        .initQuizs(Provider.of<UserProvider>(
                                                context,
                                                listen: false)
                                            .user
                                            .id)
                                        .then((value) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return const QuizScreen();
                                        }),
                                      );
                                    });
                                  }
                                },
                              );
                            }
                          },
                          child: Text(
                            "  ????????????  ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.027,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.07,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        color: Colors.lightGreen,
                        child: TextButton(
                          onPressed: () {
                            getLoadingDialog(context);
                            Provider.of<QuizProvider>(context, listen: false)
                                .quizMode = QuizMode.study;
                            Provider.of<QuizProvider>(context, listen: false)
                                .currentQuizMeta = quizMeta;
                            Provider.of<QuizProvider>(context, listen: false)
                                .initQuizs(Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user
                                    .id)
                                .then(
                              (value) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const QuizScreen();
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "  ????????????  ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.027,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
