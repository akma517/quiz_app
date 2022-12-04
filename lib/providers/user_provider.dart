import 'package:flutter/material.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/services/user_service.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  UserService userService = UserService();

  Future<bool> login(id, password) async {
    User tmpUser = await userService.getUser(id, password);
    if (tmpUser.id.isEmpty) return false;
    user = tmpUser;

    final prefs = SharedPreferencesPlugin();

    await prefs.setValue("String", "flutter.id", user.id);
    await prefs.setValue("String", "flutter.name", user.name);
    await prefs.setValue("Int", "flutter.auth", user.auth);
    await prefs.setValue("String", "flutter.subscribeName", user.subscribeName);
    await prefs.setValue("String", "flutter.startDate", user.startDate);
    await prefs.setValue("String", "flutter.endDate", user.endDate);

    return true;
  }

  Future<bool> changeUserPassword(password, newPassword) async {
    bool isSuccess =
        await userService.modifyUserPassword(user.id, password, newPassword);
    return isSuccess ? true : false;
  }

  Future<bool> autologin() async {
    final prefs = SharedPreferencesPlugin();

    Map<String, dynamic> parsed = await prefs.getAll();

    String? id = parsed["flutter.id"];
    String? name = parsed['flutter.name'];
    int? auth = parsed['flutter.auth'];
    String? subscribeName = parsed['flutter.subscribeName'];
    String? startDate = parsed['flutter.startDate'];
    String? endDate = parsed['flutter.endDate'];

    bool success = false;

    if (!(id == null) &&
        !(name == null) &&
        !(auth == null) &&
        !(subscribeName == null) &&
        !(startDate == null) &&
        !(endDate == null)) {
      if (DateTime.now()
              .toString()
              .substring(0, 10)
              .replaceAll('-', '')
              .compareTo(endDate) ==
          1) {
        auth = 1;
        subscribeName = "None";
        startDate = "None";
        endDate = "None";
        await prefs.remove("flutter.auth");
        await prefs.setValue("Int", "flutter.auth", auth);
        await prefs.remove("flutter.subscribeName");
        await prefs.setValue("String", "flutter.subscribeName", subscribeName);
        await prefs.remove("flutter.startDate");
        await prefs.setValue("String", "flutter.startDate", startDate);
        await prefs.remove("flutter.endDate");
        await prefs.setValue("String", "flutter.endDate", endDate);
      }

      user = User.autoLogin(id, name, auth, subscribeName, startDate, endDate);

      await userService.addLoginlog(id).then(
            (value) => success = value,
          );
    }

    return success;
  }

  Future<bool> logout() async {
    final prefs = SharedPreferencesPlugin();

    await prefs.remove("flutter.id");
    await prefs.remove("flutter.name");
    await prefs.remove("flutter.auth");
    await prefs.remove("flutter.subscribeName");
    await prefs.remove("flutter.startDate");
    await prefs.remove("flutter.endDate");

    user = User.logout("");

    return true;
  }

  // Future<bool> login(id, password) async {
  //   User tmpUser = await userService.getUser(id, password);
  //   if (tmpUser.id.isEmpty) return false;
  //   user = tmpUser;

  //   return true;
  // }

  // Future<bool> changeUserPassword(password, newPassword) async {
  //   bool isSuccess =
  //       await userService.modifyUserPassword(user.id, password, newPassword);
  //   return isSuccess ? true : false;
  // }

  // Future<bool> autologin() async {
  //   bool success;
  //   user = User.autoLogin('hus2112', '송현우', 99, 'kico', '00010101', '99991231');

  //   await userService.addLoginlog('hus2112').then(
  //         (value) => success = value,
  //       );

  //   return true;
  // }

  // Future<bool> logout() async {
  //   user = User.logout("");

  //   return true;
  // }
}
