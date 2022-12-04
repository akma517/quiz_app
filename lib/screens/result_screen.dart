import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/widgets/result_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    int score = Provider.of<QuizProvider>(context, listen: false).score;
    List<Quiz> quizs = Provider.of<QuizProvider>(context, listen: false).quizs;
    bool isPassed = score >= 750 ? true : false;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResultCard(
            height: height,
            quzis: quizs,
            score: score,
            isPassed: isPassed,
          ),
        ],
      ),
    );
  }
}
