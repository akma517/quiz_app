import 'package:flutter/material.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:provider/provider.dart';

Future<dynamic> getBookmarks(
    double height, void Function(int i) moveQuizIndex, BuildContext context) {
  List<Quiz> quizs = Provider.of<QuizProvider>(context, listen: false)
      .quizs
      .where(
        (quiz) => quiz.bookmarked == 'Y',
      )
      .toList();
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
              for (var i = 0; i < quizs.length; i++)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: Colors.orange.shade300,
                    elevation: 3,
                    child: TextButton(
                      onPressed: () {
                        Provider.of<QuizProvider>(context, listen: false)
                                    .quizMode ==
                                QuizMode.bookmarks
                            ? moveQuizIndex(i)
                            : moveQuizIndex(quizs[i].realQuestionNo - 1);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "${quizs[i].realQuestionNo}",
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.025),
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
