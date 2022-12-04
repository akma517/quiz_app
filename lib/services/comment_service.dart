import 'dart:convert';
import 'package:hus_quiz/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:hus_quiz/utilities/adapters/comment_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/comment_query_properties.dart';

class CommentService {
  Future<bool> addComment(Comment comment) async {
    late final http.Response response;
    response = await http.post(
      postComment("add"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(comment),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> modifyComment(Comment comment) async {
    late final http.Response response;
    response = await http.post(
      postComment("modify"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(comment),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> removeAllComment(int boardNo) async {
    late final http.Response response;
    response = await http.post(
      postComment("remove_all"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "board_no": boardNo,
        },
      ),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> removeComment(Comment comment) async {
    late final http.Response response;
    response = await http.post(
      postComment("remove"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(comment),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<List<Comment>> getComments(int boardNo) async {
    late final http.Response response;
    response = await http.get(
      getComment(boardNo),
    );

    if (response.statusCode == 200) {
      return parseComment(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
