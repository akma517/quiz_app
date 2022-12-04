import 'dart:convert';

import 'package:hus_quiz/models/test_history.dart';

List<TestHistory> parseTestHistory(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<TestHistory> testHistories =
      parsed.map<TestHistory>((json) => TestHistory.fromJson(json)).toList();

  return testHistories;
}

bool parseSuccessYn(String responseBody) {
  final result = json.decode(responseBody);
  return result["success_cnt"] == 0 ? false : true;
}
