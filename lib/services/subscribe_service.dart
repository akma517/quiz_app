import 'dart:convert';
import 'package:hus_quiz/models/subscribe.dart';
import 'package:http/http.dart' as http;
import 'package:hus_quiz/models/subscribe_state.dart';
import 'package:hus_quiz/utilities/adapters/subscribe_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/subscribe_query_properties.dart';

class SubscribeService {
  Future<List<Subscribe>> getSubscribes() async {
    late final http.Response response;
    response = await http.get(getSubscribe());

    if (response.statusCode == 200) {
      return parseSubscribes(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<SubscribeState> getSubscribeState(String userId) async {
    late final http.Response response;
    response = await http.post(
      postSubscribeState(),
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
      return parseSubscribeState(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
