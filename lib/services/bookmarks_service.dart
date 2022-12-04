import 'dart:convert';
import 'package:hus_quiz/models/bookmarks.dart';
import 'package:hus_quiz/utilities/adapters/bookmarks_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/bookmarks_query_properties.dart';
import 'package:http/http.dart' as http;

class BookmarksService {
  Future<List<Bookmarks>> getBookmarks(String userId) async {
    late final http.Response response;
    response = await http.post(
      postBookmarks("get"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "user_id": userId,
        },
      ),
    );

    if (response.statusCode == 200) {
      return parseBookmarks(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> addBookmark(int quizNo, int questionNo, String userId) async {
    late final http.Response response;
    response = await http.post(
      postBookmarks("add"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "quiz_no": quizNo,
          "question_no": questionNo,
          "user_id": userId,
        },
      ),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> removeBookmark(int quizNo, int questionNo, String userId) async {
    late final http.Response response;
    response = await http.post(
      postBookmarks("remove"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "quiz_no": quizNo,
          "question_no": questionNo,
          "user_id": userId,
        },
      ),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
