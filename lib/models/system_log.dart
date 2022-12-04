abstract class SystemLog {
  late String userId;
  late String testDate;
  late String loginDate;
  late int cnt;

  SystemLog.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'].toString();
}
