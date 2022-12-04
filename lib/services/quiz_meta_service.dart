import 'dart:convert';
import 'package:hus_quiz/models/quiz_meta.dart';
import 'package:hus_quiz/utilities/adapters/quiz_meta_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/quiz_meta_query_properties.dart';
import 'package:http/http.dart' as http;

class QuizMetaService {
  Future<List<QuizMeta>> getQuizMetas() async {
    late final http.Response response;
    response = await http.get(getQuizMeta());

    if (response.statusCode == 200) {
      return parseQuizMetas(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
