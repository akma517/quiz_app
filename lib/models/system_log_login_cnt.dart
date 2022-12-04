import 'package:hus_quiz/models/system_log.dart';

class SystemLogLoginCnt implements SystemLog {
  @override
  String userId;
  @override
  int cnt;
  @override
  late String loginDate;
  @override
  late String testDate;

  SystemLogLoginCnt.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'].toString(),
        cnt = int.parse(json['cnt'].toString());
}
