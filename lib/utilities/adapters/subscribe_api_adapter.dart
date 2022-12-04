import 'dart:convert';

import 'package:hus_quiz/models/subscribe.dart';
import 'package:hus_quiz/models/subscribe_state.dart';

List<Subscribe> parseSubscribes(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return [];
  List<Subscribe> parsedSubscribes =
      parsed.map<Subscribe>((json) => Subscribe.fromJson(json)).toList();

  return parsedSubscribes;
}

SubscribeState parseSubscribeState(String responseBody) {
  final parsed = json.decode(responseBody);
  if (parsed == null) return SubscribeState.noSubscribe(0);
  SubscribeState parsedSubscribeState = parsed
      .map<SubscribeState>((json) => SubscribeState.fromJson(json))
      .toList()[0];

  return parsedSubscribeState;
}
