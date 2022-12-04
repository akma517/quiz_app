import 'dart:convert';
import 'package:hus_quiz/models/board.dart';
import 'package:http/http.dart' as http;
import 'package:hus_quiz/utilities/adapters/board_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/board_query_properties.dart';

class BoardService {
  Future<bool> addBoard(Board board) async {
    late final http.Response response;
    response = await http.post(
      postBoard("add"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(board),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> modifyBoard(Board board) async {
    late final http.Response response;
    response = await http.post(
      postBoard("modify"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(board),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> removeBoard(Board board) async {
    late final http.Response response;
    response = await http.post(
      postBoard("remove"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(board),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<List<Board>> getBoardList(int boardCategory) async {
    late final http.Response response;
    response = await http.get(
      getBoard(boardCategory),
    );

    if (response.statusCode == 200) {
      return parseBoard(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
