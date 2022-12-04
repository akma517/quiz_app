import 'dart:convert';

import 'package:hus_quiz/models/quiz_meta.dart';

List<QuizMeta> parseQuizMetas(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<QuizMeta> parsedQuizMetas =
      parsed.map<QuizMeta>((json) => QuizMeta.fromJson(json)).toList();

  return parsedQuizMetas;
}
