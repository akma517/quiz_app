import 'dart:convert';
import 'package:hus_quiz/models/test_history.dart';
import 'package:hus_quiz/utilities/adapters/test_history_api_adapter.dart';
import 'package:http/http.dart' as http;
import 'package:hus_quiz/utilities/properties/test_history_query_properties.dart';

class TestHistoryService {
  Future<bool> addTestHistory(TestHistory targetTestHistory) async {
    late final http.Response response;
    response = await http.post(
      postTestHistory("add", targetTestHistory.userId),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(targetTestHistory),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<List<TestHistory>> getTestHistories(String userId) async {
    late final http.Response response;
    response = await http.get(
      getTestHistory("get", userId),
    );

    if (response.statusCode == 200) {
      return parseTestHistory(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
