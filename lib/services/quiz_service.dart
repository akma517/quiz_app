import 'dart:convert';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/models/quiz_meta.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/utilities/adapters/quiz_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/quiz_query_properties.dart';
import 'package:http/http.dart' as http;

class QuizService {
  bool initQuizsScore(List<Quiz> targetQuizs, QuizMeta targetQuizMeta) {
    List<int> scores = []; // = {0:10 10:30,20:20,30:10,40:5};

    List<int> quizScores = targetQuizMeta.questionScores
        .split(',')
        .map((score) => int.parse(score))
        .toList();

    List<int> quizScoreCounts = targetQuizMeta.questionScoreCounts
        .split(',')
        .map((count) => int.parse(count))
        .toList();

    for (int i = 0; i < quizScores.length; i++) {
      for (int j = 0; j < quizScoreCounts[i]; j++) {
        scores.add(quizScores[i]);
      }
    }

    scores.shuffle();

    int i = 0;
    for (Quiz quiz in targetQuizs) {
      quiz.questionId = i + 1;
      quiz.score = scores[i];
      i += 1;
    }

    return true;
  }

  int calcQuizsScore(List<Quiz> targetQuizs) {
    for (Quiz quiz in targetQuizs) {
      quiz.answer == quiz.useranswer
          ? quiz.isCorrect = true
          : quiz.isCorrect = false;
    }

    var filteredQuizs = targetQuizs.where((quiz) => quiz.isCorrect == true);

    int totalScore = 0;

    for (Quiz quiz in filteredQuizs) {
      totalScore += quiz.score;
    }

    return totalScore;
  }

  bool checkAllSolved(List<Quiz> targetQuizs) {
    bool isSolved = true;

    for (Quiz quiz in targetQuizs) {
      if (quiz.useranswer.isEmpty) {
        isSolved = false;
        break;
      }
    }
    return isSolved;
  }

  Future<List<Quiz>> getQuizs(status, quizNo, userId) async {
    late final http.Response response;
    if (status == QuizMode.test) {
      response = await http.get(getQuizTest(quizNo, userId));
    } else if (status == QuizMode.study) {
      response = await http.get(getQuizStudy(quizNo, userId));
    } else if (status == QuizMode.review) {
      response = await http.get(getQuizStudy(quizNo, userId));
    } else if (status == QuizMode.bookmarks) {
      response = await http.get(getQuizStudy(quizNo, userId));
    }

    if (response.statusCode == 200) {
      return parseQuizs(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
