import 'dart:convert';

import 'package:hus_quiz/models/user.dart';

User parseUser(String responseBody) {
  if (!responseBody.contains('"')) return User.failed("");
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>()[0];

  User user = User.fromJson(parsed);

  return user;
}

bool parseSuccessYn(String responseBody) {
  final result = json.decode(responseBody);
  return result["success_cnt"] == 0 ? false : true;
}
