import 'package:flutter/material.dart';
import 'package:hus_quiz/models/subscribe.dart';
import 'package:hus_quiz/models/subscribe_state.dart';
import 'package:hus_quiz/services/subscribe_service.dart';

class SubscribeProvider extends ChangeNotifier {
  late List<Subscribe> subscribes;
  late List<List<Subscribe>> subscribesByProdcut;
  late SubscribeState subscribeState;

  SubscribeService subscribeService = SubscribeService();

  Future<bool> initSubscribeProducts() async {
    subscribes = await subscribeService.getSubscribes();
    Set<String> subscribeNames = {};
    for (var e in subscribes) {
      subscribeNames.add(e.subscribeName);
    }

    subscribesByProdcut = [];
    for (var x in subscribeNames) {
      subscribesByProdcut
          .addAll({subscribes.where((y) => y.subscribeName == x).toList()});
    }
    return true;
  }

  Future<bool> getSubscribeState(String userId) async {
    subscribeState = await subscribeService.getSubscribeState(userId);

    return true;
  }
}
