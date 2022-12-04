import 'package:flutter/material.dart';
import 'package:hus_quiz/utilities/functions/get_card_color.dart';
import 'package:provider/provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';

class AnswerCard extends StatefulWidget {
  AnswerCard({
    Key? key,
    required this.height,
    required this.answerIndex,
  }) : super(key: key);

  final Map<int, String> answerMap = {
    0: "A",
    1: "B",
    2: "C",
    3: "D",
    4: "E",
    5: "F",
    6: "G",
  };

  final double height;
  final int answerIndex;

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  @override
  Widget build(BuildContext context) {
    bool isChoiced = false;
    final int currentQuizIndex =
        Provider.of<QuizProvider>(context, listen: false).currentQuizIndex - 1;
    final String answer = widget.answerMap[widget.answerIndex].toString();
    final String text = Provider.of<QuizProvider>(context, listen: false).isKor
        ? Provider.of<QuizProvider>(context, listen: false)
            .quizs[currentQuizIndex]
            .candidates_kor[widget.answerIndex]
        : Provider.of<QuizProvider>(context, listen: false)
            .quizs[currentQuizIndex]
            .candidates_eng[widget.answerIndex];

    final bool isContains = Provider.of<QuizProvider>(context, listen: false)
        .quizs[currentQuizIndex]
        .useranswer
        .contains(answer);
    final quizMode = Provider.of<QuizProvider>(context, listen: false).quizMode;

    if (isContains) {
      isChoiced = true;
    }

    Color color =
        getCardColor(quizMode, isChoiced, context, currentQuizIndex, answer);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: SizedBox(
        child: Card(
          color: color,
          elevation: 5,
          child: TextButton(
            onPressed: () {
              // print(Provider.of<QuizProvider>(context, listen: false)
              //     .quizs[currentQuizIndex]
              //     .realQuestionId);
              quizMode == QuizMode.test
                  ? setState(() {
                      if (isContains && isChoiced == true) {
                        Provider.of<QuizProvider>(context, listen: false)
                            .setUserAnswer(true, answer, currentQuizIndex);
                      } else {
                        if (Provider.of<QuizProvider>(context, listen: false)
                                .quizs[currentQuizIndex]
                                .useranswer
                                .length <
                            Provider.of<QuizProvider>(context, listen: false)
                                .quizs[currentQuizIndex]
                                .answer
                                .length) {
                          Provider.of<QuizProvider>(context, listen: false)
                              .setUserAnswer(false, answer, currentQuizIndex);
                        }
                      }
                      isChoiced = !isChoiced;
                    })
                  : quizMode == QuizMode.study
                      ? setState(() {
                          if (isContains && isChoiced == true) {
                            Provider.of<QuizProvider>(context, listen: false)
                                .setUserAnswer(true, answer, currentQuizIndex);
                          } else {
                            if (Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .quizs[currentQuizIndex]
                                    .useranswer
                                    .length <
                                Provider.of<QuizProvider>(context,
                                        listen: false)
                                    .quizs[currentQuizIndex]
                                    .answer
                                    .length) {
                              Provider.of<QuizProvider>(context, listen: false)
                                  .setUserAnswer(
                                      false, answer, currentQuizIndex);
                            }
                          }
                          isChoiced = !isChoiced;
                        })
                      : () {};
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.left,
                "${text.trim()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: widget.height * 0.02,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
