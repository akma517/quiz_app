import 'dart:convert';

import 'package:hus_quiz/models/quiz.dart';

List<Quiz> parseQuizs(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<Quiz> parsedQuizs =
      parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();

  for (var quiz in parsedQuizs) {
    var filteredCandidatesKor =
        quiz.candidates_kor.where((candidate) => candidate != "None").toList();
    quiz.candidates_kor = filteredCandidatesKor;
    var filteredCandidatesEng =
        quiz.candidates_eng.where((candidate) => candidate != "None").toList();
    quiz.candidates_eng = filteredCandidatesEng;
  }

  return parsedQuizs;
}

bool parseSuccessYn(String responseBody) {
  final result = json.decode(responseBody);
  return result["success_cnt"] == 0 ? false : true;
}
