import 'package:flutter/material.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/screens/home_screen.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_plain_service_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_user_service_dialog.dart';
import 'package:provider/provider.dart';

List<Widget> getQuizActions(
    Quiz quiz, QuizMode quizMode, int quizIndex, BuildContext context) {
  List<Widget> quizActions = [];
  Size screenSize = MediaQuery.of(context).size;
  double height = screenSize.height;
  double width = screenSize.width;
  User user = Provider.of<UserProvider>(context, listen: false).user;

  if (quizMode == QuizMode.study) {
    quizActions.add(
      IconButton(
        icon: Icon(
            quiz.bookmarked == 'Y' ? Icons.bookmark_added : Icons.bookmark_add),
        color: quiz.bookmarked == 'Y' ? Colors.orange.shade300 : Colors.white,
        onPressed: () {
          if (user.auth < 1) {
            getOnlyUserServiceDialog(context);
          } else if (user.auth < 2) {
            getOnlyPlainServiceDialog(context);
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    width: width * 0.4,
                    height: height * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quiz.bookmarked == 'N'
                              ? "북마크에 추가하시겠습니까?"
                              : "북마크에서 삭제하시겠습니까?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: height * 0.018,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: OutlinedButton(
                            onPressed: () {
                              getLoadingDialog(context);
                              if (quiz.bookmarked == 'Y') {
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .removeBookmarkInStudy(
                                  quiz.quizNo,
                                  quiz.realQuestionNo,
                                  user.id,
                                )
                                    .then(
                                  (value) {
                                    Navigator.pop(context);
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
                                                    "북마크에서 삭제되었습니다.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                                                      0.25,
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "확인",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
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
                                  },
                                );
                              } else {
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .addBookmarkInStudy(
                                  quiz.quizNo,
                                  quiz.realQuestionNo,
                                  user.id,
                                )
                                    .then(
                                  (value) {
                                    Navigator.pop(context);
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
                                                    "북마크에 추가되었습니다.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                                                      0.25,
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "확인",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
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
                                  },
                                );
                              }
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "취소",
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
                  insetPadding:
                      const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                );
              },
            );
          }
        },
      ),
    );
    quizActions.add(
      IconButton(
        onPressed: () {
          Provider.of<QuizProvider>(context, listen: false)
              .checkQuestion(quizIndex);
        },
        icon: const Icon(Icons.flag),
        color: quiz.isChecked ? Colors.orange.shade300 : Colors.white,
      ),
    );
  } else if (quizMode == QuizMode.review) {
    quizActions.add(
      IconButton(
        icon: Icon(
            quiz.bookmarked == 'Y' ? Icons.bookmark_added : Icons.bookmark_add),
        color: quiz.bookmarked == 'Y' ? Colors.orange.shade300 : Colors.white,
        onPressed: () {
          if (user.auth < 1) {
            getOnlyUserServiceDialog(context);
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    width: width * 0.4,
                    height: height * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quiz.bookmarked == 'N'
                              ? "북마크에 추가하시겠습니까?"
                              : "북마크에서 삭제하시겠습니까?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: height * 0.018,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: OutlinedButton(
                            onPressed: () {
                              if (quiz.bookmarked == 'Y') {
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .removeBookmarkInReview(
                                  quiz.quizNo,
                                  quiz.realQuestionNo,
                                  user.id,
                                )
                                    .then(
                                  (value) {
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
                                                    "북마크에서 삭제되었습니다.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                                                      0.25,
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "확인",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
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
                                  },
                                );
                              } else {
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .addBookmarkInReview(
                                  quiz.quizNo,
                                  quiz.realQuestionNo,
                                  user.id,
                                )
                                    .then(
                                  (value) {
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
                                                    "북마크에 추가되었습니다.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                                                      0.25,
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "확인",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
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
                                  },
                                );
                              }
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "취소",
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
                  insetPadding:
                      const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                );
              },
            );
          }
        },
      ),
    );
    quizActions.add(
      IconButton(
        onPressed: () {
          Provider.of<QuizProvider>(context, listen: false)
              .checkQuestion(quizIndex);
        },
        icon: const Icon(Icons.flag),
        color: quiz.isChecked ? Colors.orange.shade300 : Colors.white,
      ),
    );
  } else if (quizMode == QuizMode.bookmarks) {
    quizActions.add(
      IconButton(
        icon: const Icon(Icons.bookmark_added),
        color: Colors.orange.shade300,
        onPressed: () {
          if (user.auth < 1) {
            getOnlyUserServiceDialog(context);
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    width: width * 0.4,
                    height: height * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "북마크에서 삭제하시겠습니까?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: height * 0.018,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: OutlinedButton(
                            onPressed: () {
                              if (quiz.bookmarked == 'Y') {
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .removeBookmarkInBookmarks(
                                  quiz.quizNo,
                                  quiz.realQuestionNo,
                                  Provider.of<QuizProvider>(context,
                                          listen: false)
                                      .currentQuizIndex,
                                  user.id,
                                  Provider.of<QuizProvider>(context,
                                                  listen: false)
                                              .quizs
                                              .length ==
                                          1
                                      ? false
                                      : true,
                                )
                                    .then(
                                  (value) {
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
                                                    "북마크에서 삭제되었습니다.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                                                      0.25,
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      if (Provider.of<QuizProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .quizs
                                                              .length ==
                                                          1) {
                                                        Provider.of<QuizProvider>(
                                                                context,
                                                                listen: false)
                                                            .initBookmarks(
                                                          user.id,
                                                        )
                                                            .then(
                                                          (value) {
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  Provider.of<MenuProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .setMenuTitle(
                                                                          Menu.bookmarks);
                                                                  return const HomeScreen();
                                                                },
                                                              ),
                                                              (route) => false,
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text(
                                                      "확인",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize:
                                                            height * 0.018,
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
                                  },
                                );
                              }
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "취소",
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
                  insetPadding:
                      const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                );
              },
            );
          }
        },
      ),
    );
  } else if (quizMode == QuizMode.test) {
    quizActions.add(
      IconButton(
        onPressed: () {
          Provider.of<QuizProvider>(context, listen: false)
              .checkQuestion(quizIndex);
        },
        icon: const Icon(Icons.flag),
        color: quiz.isChecked ? Colors.orange.shade300 : Colors.white,
      ),
    );
  }

  quizActions.add(
    IconButton(
      onPressed: () =>
          Provider.of<QuizProvider>(context, listen: false).translateLanguage(),
      icon: const Icon(Icons.translate),
    ),
  );

  return quizActions;
}
