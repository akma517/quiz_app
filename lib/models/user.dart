class User {
  late String id;
  late String password;
  late String name;
  late int auth;
  late String subscribeName;
  late String startDate;
  late String endDate;

  User(this.id, this.name, this.auth);
  User.failed(this.id);

  User.autoLogin(
    this.id,
    this.name,
    this.auth,
    this.subscribeName,
    this.startDate,
    this.endDate,
  );
  User.logout(
    this.id,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'].toString(),
        auth = int.parse(json['auth'].toString()),
        subscribeName = json['subscribe_name'].toString(),
        startDate = json['start_date'].toString(),
        endDate = json['end_date'].toString();
}
