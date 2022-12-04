import 'dart:convert';
import 'package:hus_quiz/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:hus_quiz/utilities/adapters/user_api_adapter.dart';
import 'package:hus_quiz/utilities/properties/user_query_properties.dart';

class UserService {
  Future<bool> addLoginlog(id) async {
    late final http.Response response;
    response = await http.post(
      postUser("history"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "id": id,
      }),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<bool> modifyUserPassword(id, password, newPassword) async {
    late final http.Response response;
    response = await http.post(
      postUser("password"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "id": id,
        "password": password,
        "new_password": newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return parseSuccessYn(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }

  Future<User> getUser(id, password) async {
    late final http.Response response;
    response = await http.post(
      postUser("login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "id": id,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return parseUser(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("connect failed");
    }
  }
}
