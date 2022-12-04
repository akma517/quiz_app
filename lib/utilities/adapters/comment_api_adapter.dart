import 'dart:convert';

import 'package:hus_quiz/models/comment.dart';

List<Comment> parseComment(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<Comment> comments =
      parsed.map<Comment>((json) => Comment.fromJson(json)).toList();

  return comments;
}

bool parseSuccessYn(String responseBody) {
  final result = json.decode(responseBody);
  return result["success_cnt"] == 0 ? false : true;
}
