import 'package:flutter/material.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_user_service_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_bookmarks.dart';
import 'package:hus_quiz/utilities/functions/get_questions.dart';
import 'package:hus_quiz/widgets/answer_card.dart';
import 'package:provider/provider.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/screens/result_screen.dart';

import '../utilities/functions/get_quiz_actions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ScrollController _scrollController = ScrollController();
  var scrollIcon = Icons.unfold_more_sharp;

  void _scrollToTop() {
    setState(() {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 600), curve: Curves.ease);
    });
  }

  void _scrollToAnwerCardStart() {
    setState(() {
      _scrollController.animateTo(MediaQuery.of(context).size.height * 0.77,
          duration: const Duration(milliseconds: 600), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    int quizIndex = Provider.of<QuizProvider>(context).currentQuizIndex;
    Quiz quiz = Provider.of<QuizProvider>(context).quizs[quizIndex - 1];
    int testTime = Provider.of<QuizProvider>(context).testTime;
    int quizsLength = Provider.of<QuizProvider>(context).quizs.length;
    QuizMode quizMode = Provider.of<QuizProvider>(context).quizMode;
    String question = Provider.of<QuizProvider>(context).isKor
        ? quiz.question_kor
        : quiz.question_eng;
    User user = Provider.of<UserProvider>(context).user;
    Widget timer = quizMode == QuizMode.test
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer_sharp),
              Text(
                "${(testTime / 60).floor().toString()}:${(testTime % 60).toString().length > 1 ? (testTime % 60).toString() : "0${testTime % 60}"}",
                style: TextStyle(
                  fontSize: 15,
                  color: testTime > 300 ? Colors.white : Colors.red,
                ),
              ),
            ],
          )
        : quizMode == QuizMode.review
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  "배점\n${quiz.score}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600),
                ),
              )
            : const SizedBox();

    void _moveQuizIndex(int i) {
      Provider.of<QuizProvider>(context, listen: false)
          .setCurrentQuizIndex(i + 1);
      _scrollToTop();
    }

    bool _isSolved(int i) => Provider.of<QuizProvider>(context, listen: false)
        .quizs[i]
        .useranswer
        .isNotEmpty;
    bool _isChecked(int i) =>
        Provider.of<QuizProvider>(context).quizs[i].isChecked;
    bool _submmitQuizs() {
      return Provider.of<QuizProvider>(context, listen: false).submmitQuizs();
    }

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 80.0,
            title: Text(
              quizMode != QuizMode.bookmarks
                  ? 'Q${Provider.of<QuizProvider>(context, listen: false).currentQuizIndex}'
                  : 'Q${quiz.realQuestionNo}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
            leading: timer,
            actions: getQuizActions(quiz, quizMode, quizIndex, context),
            pinned: true,
            expandedHeight: height * 0.91,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(18.0),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              background: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.0195,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.square(height * 0.06),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(18.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: height * 0.12,
                          height: height * 0.05,
                          child: GestureDetector(
                            onTap: () {
                              if (quizIndex > 1) {
                                _scrollToTop();
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .setCurrentQuizIndex(quizIndex - 1);
                              }
                            },
                            child: Card(
                              color: quizIndex > 1
                                  ? Colors.blue.shade300
                                  : Colors.grey.shade400,
                              elevation: 5,
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white,
                                size: height * 0.04,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: height * 0.12,
                          height: height * 0.05,
                          child: GestureDetector(
                            onTap: () {
                              if (_scrollController.offset ==
                                  _scrollController.position.minScrollExtent) {
                                _scrollToAnwerCardStart();
                              } else {
                                _scrollToTop();
                              }
                            },
                            child: Card(
                              color: Colors.blue.shade300,
                              elevation: 5,
                              child: Icon(
                                scrollIcon,
                                color: Colors.white,
                                size: height * 0.04,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: height * 0.12,
                          height: height * 0.05,
                          child: GestureDetector(
                            onTap: () {
                              if (quizIndex < quizsLength) {
                                _scrollToTop();
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .setCurrentQuizIndex(quizIndex + 1);
                              }
                            },
                            child: Card(
                              color: quizIndex < quizsLength
                                  ? Colors.blue.shade300
                                  : Colors.grey.shade400,
                              elevation: 5,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: height * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.fromLTRB(0, 0, 0, 16.0)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    AnswerCard(height: height, answerIndex: index),
                childCount: quiz.candidates_kor.length),
          ),
          SliverPadding(padding: EdgeInsets.fromLTRB(0, height * 0.4, 0, 0)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: height * 0.065,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: height * 0.1,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      var giveUp = false;

                      quizMode == QuizMode.test
                          ? showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Center(
                                      child: Text(
                                    "시험을 포기하시겠습니까?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  content: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: height * 0.1,
                                    child: Row(
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
                                                giveUp = true;
                                                Navigator.pop(context);
                                              },
                                              child: Text("예",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: height * 0.018,
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
                                              child: Text("아니요",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: height * 0.018,
                                                  )),
                                            ),
                                          )
                                        ]),
                                  ),
                                  insetPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 20.0, 20.0),
                                );
                              }).then(
                              (value) {
                                if (giveUp) {
                                  getLoadingDialog(context);
                                  Provider.of<QuizProvider>(context,
                                          listen: false)
                                      .addTestHistory(
                                          user.id,
                                          Provider.of<QuizProvider>(context,
                                                  listen: false)
                                              .currentQuizMeta
                                              .quizNo,
                                          "N")
                                      .then(
                                    (value) {
                                      Navigator.pop(context);
                                      Provider.of<QuizProvider>(context,
                                              listen: false)
                                          .timerCancel();
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                              },
                            )
                          : Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel_presentation),
                        Text(
                          "cancel",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              quizMode != QuizMode.bookmarks
                  ? SizedBox(
                      width: height * 0.1,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.zero),
                          onTap: () {
                            getQuestions(height, quizsLength, _isSolved,
                                _moveQuizIndex, _isChecked, quizMode, context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.grid_view_sharp),
                              Text(
                                "questions",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: height * 0.1,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.zero),
                          onTap: () {
                            getBookmarks(
                              height,
                              _moveQuizIndex,
                              context,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.bookmark),
                              Text(
                                "bookmarks",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                width: height * 0.1,
                child: quizMode == QuizMode.test
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            var allSolved = _submmitQuizs();
                            Widget titleWidget = Text(
                              allSolved
                                  ? "문제를 모두 풀었습니다.\n답안지를 제출하여 결과를 확인하시겠습니까?"
                                  : "아직 풀지 못한 문제가 존재합니다.\n답안지를 제출하여 결과를 확인하시겠습니까?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            );
                            var submmit = false;

                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  title: titleWidget,
                                  content: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: height * 0.1,
                                    child: Row(
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
                                              submmit = true;
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "예",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: height * 0.018,
                                              ),
                                            ),
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
                                            child: Text(
                                              "아니요",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: height * 0.018,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  insetPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 20.0, 20.0),
                                );
                              },
                            ).then(
                              (value) {
                                if (submmit) {
                                  getLoadingDialog(context);
                                  Provider.of<QuizProvider>(context,
                                          listen: false)
                                      .addTestHistory(
                                    user.id,
                                    Provider.of<QuizProvider>(context,
                                            listen: false)
                                        .currentQuizMeta
                                        .quizNo,
                                    "Y",
                                  )
                                      .then(
                                    (value) {
                                      Navigator.pop(context);
                                      Provider.of<QuizProvider>(context,
                                              listen: false)
                                          .timerCancel();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const ResultScreen();
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.next_plan_outlined),
                              Text(
                                "submisson",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    // : quizMode == QuizMode.study
                    //     ? quiz.useranswer.length >= quiz.answer.length
                    //         ? SizedBox(
                    //             child: Text(
                    //               "정답 : ${quiz.answer}",
                    //               style: TextStyle(fontSize: 15.0),
                    //             ),
                    //           )
                    : quizMode == QuizMode.study
                        ? SizedBox(
                            width: height * 0.1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.zero),
                                onTap: () {
                                  if (user.auth < 1) {
                                    getOnlyUserServiceDialog(context);
                                  } else {
                                    getBookmarks(
                                      height,
                                      _moveQuizIndex,
                                      context,
                                    );
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.bookmark),
                                    Text(
                                      "bookmarks",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : quizMode == QuizMode.review
                            ? SizedBox(
                                width: height * 0.1,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius:
                                        const BorderRadius.all(Radius.zero),
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (quiz.isCorrect)
                                          Icon(Icons.circle_outlined,
                                              color: Colors.green.shade400),
                                        if (!quiz.isCorrect)
                                          Icon(Icons.highlight_remove,
                                              color: Colors.red.shade400),
                                        Text(
                                            quiz.isCorrect ? 'corret' : 'wrong',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: quiz.isCorrect
                                                    ? Colors.green.shade400
                                                    : Colors.red.shade400)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
