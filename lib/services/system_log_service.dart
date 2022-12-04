import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hus_quiz/models/system_log.dart';
import 'package:hus_quiz/utilities/adapters/system_log_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/system_log_query_properties.dart';

class SystemLogService {
  Future<List<SystemLog>> getLogs(option) async {
    late final http.Response response;
    response = await http.get(
      getSystemLogs(option),
    );

    if (response.statusCode == 200) {
      return parseSystemLogs(utf8.decode(response.bodyBytes), option);
    } else {
      throw Exception("connect failed");
    }
  }
}
