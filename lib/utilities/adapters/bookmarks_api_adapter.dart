import 'dart:convert';

import 'package:hus_quiz/models/bookmarks.dart';

List<Bookmarks> parseBookmarks(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<Bookmarks> parsedBookmarks =
      parsed.map<Bookmarks>((json) => Bookmarks.fromJson(json)).toList();

  return parsedBookmarks;
}

bool parseSuccessYn(String responseBody) {
  final result = json.decode(responseBody);
  return result["success_cnt"] == 0 ? false : true;
}
