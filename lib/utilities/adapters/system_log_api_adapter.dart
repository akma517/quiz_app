import 'dart:convert';
import 'package:hus_quiz/models/system_log.dart';
import 'package:hus_quiz/models/system_log_login.dart';
import 'package:hus_quiz/models/system_log_login_cnt.dart';
import 'package:hus_quiz/models/system_log_test.dart';

List<SystemLog> parseSystemLogs(String responseBody, String option) {
  final parsed = json.decode(responseBody);
  List<SystemLog> systemLog = [];
  if (parsed == null) return systemLog;

  if ("login" == option) {
    systemLog =
        parsed.map<SystemLog>((json) => SystemLogLogin.fromJson(json)).toList();
  } else if ("login_cnt" == option) {
    systemLog = parsed
        .map<SystemLog>((json) => SystemLogLoginCnt.fromJson(json))
        .toList();
  } else if ("test" == option) {
    systemLog =
        parsed.map<SystemLog>((json) => SystemLogTest.fromJson(json)).toList();
  }

  return systemLog;
}
