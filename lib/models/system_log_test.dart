import 'package:hus_quiz/models/system_log.dart';

class SystemLogTest implements SystemLog {
  @override
  String userId;
  @override
  late int cnt;
  @override
  late String loginDate;
  @override
  String testDate;

  SystemLogTest.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'].toString(),
        testDate = json['test_date'].toString();
}
