import 'dart:convert';

import 'package:hus_quiz/models/board.dart';

List<Board> parseBoard(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<Board> boardList =
      parsed.map<Board>((json) => Board.fromJson(json)).toList();

  return boardList;
}

bool parseSuccessYn(String responseBody) {
  final result = json.decode(responseBody);
  return result["success_cnt"] == 0 ? false : true;
}
