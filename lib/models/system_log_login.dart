import 'package:hus_quiz/models/system_log.dart';

class SystemLogLogin implements SystemLog {
  @override
  String userId;
  @override
  late int cnt;
  @override
  String loginDate;
  @override
  late String testDate;

  SystemLogLogin.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'].toString(),
        loginDate = json['login_date'].toString();
}
