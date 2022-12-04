import 'package:flutter/material.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:provider/provider.dart';

Future<dynamic> getQuestions(
    double height,
    int quizsLength,
    bool Function(int i) isSolved,
    void Function(int i) moveQuizIndex,
    bool Function(int i) isChecked,
    QuizMode quizMode,
    BuildContext context) {
  List<Quiz> quizs = Provider.of<QuizProvider>(context, listen: false).quizs;
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "문제",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: height * 0.6,
            child: GridView.extent(maxCrossAxisExtent: 100.0, children: [
              for (var i = 0; i < quizsLength; i++)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: quizMode != QuizMode.review
                        ? quizMode == QuizMode.study
                            ? isSolved(i)
                                ? quizs[i].useranswer.length >=
                                        quizs[i].answer.length
                                    ? quizs[i].useranswer == quizs[i].answer
                                        ? Colors.green.shade300
                                        : Colors.red.shade300
                                    : Colors.blue.shade300
                                : isChecked(i)
                                    ? Colors.orange.shade300
                                    : Colors.grey.shade400
                            : isSolved(i)
                                ? Colors.blue.shade300
                                : isChecked(i)
                                    ? Colors.orange.shade300
                                    : Colors.grey.shade400
                        : quizs[i].useranswer == quizs[i].answer
                            ? Colors.green.shade300
                            : Colors.red.shade300,
                    elevation: 3,
                    child: TextButton(
                      onPressed: () {
                        moveQuizIndex(i);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "${i + 1}",
                        style: TextStyle(
                            color: quizMode != QuizMode.review
                                ? isChecked(i)
                                    ? isSolved(i)
                                        ? Colors.orange.shade300
                                        : Colors.white
                                    : Colors.white
                                : isChecked(i)
                                    ? Colors.orange.shade300
                                    : Colors.white,
                            fontSize: height * 0.035),
                      ),
                    ),
                  ),
                )
            ]),
          ),
          insetPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        );
      });
}
