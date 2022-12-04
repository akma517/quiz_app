import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:provider/provider.dart';

Color getCardColor(QuizMode quizMode, bool isChoiced, BuildContext context,
    int currentQuizIndex, String answer) {
  final Color color;
  if (quizMode == QuizMode.test) {
    color = isChoiced ? Colors.blue.shade100 : Colors.white;
  } else {
    if (quizMode == QuizMode.study) {
      if (isChoiced) {
        color = Provider.of<QuizProvider>(context, listen: false)
                    .quizs[currentQuizIndex]
                    .useranswer
                    .length >=
                Provider.of<QuizProvider>(context, listen: false)
                    .quizs[currentQuizIndex]
                    .answer
                    .length
            ? Provider.of<QuizProvider>(context, listen: false)
                    .quizs[currentQuizIndex]
                    .answer
                    .contains(answer)
                ? Colors.green.shade100
                : Colors.red.shade100
            : Colors.blue.shade100;
      } else {
        color = Provider.of<QuizProvider>(context, listen: false)
                    .quizs[currentQuizIndex]
                    .useranswer
                    .length >=
                Provider.of<QuizProvider>(context, listen: false)
                    .quizs[currentQuizIndex]
                    .answer
                    .length
            ? Provider.of<QuizProvider>(context, listen: false)
                    .quizs[currentQuizIndex]
                    .answer
                    .contains(answer)
                ? Colors.green.shade100
                : Colors.white
            : Colors.white;
      }
    } else {
      color = isChoiced
          ? Provider.of<QuizProvider>(context, listen: false)
                  .quizs[currentQuizIndex]
                  .answer
                  .contains(answer)
              ? Colors.green.shade100
              : Colors.red.shade100
          : Provider.of<QuizProvider>(context, listen: false)
                  .quizs[currentQuizIndex]
                  .answer
                  .contains(answer)
              ? Colors.green.shade100
              : Colors.white;
    }
  }
  return color;
}
