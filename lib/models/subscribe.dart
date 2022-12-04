class Subscribe {
  int subscribeNo;
  String subscribeName;
  String subscribePeriodName;
  int price;
  int period;
  String description;

  Subscribe.fromJson(Map<String, dynamic> json)
      : subscribeNo = int.parse(json['subscribe_no'].toString()),
        subscribeName = json['subscribe_name'].toString(),
        subscribePeriodName = json['subscribe_period_name'].toString(),
        price = int.parse(json['price'].toString()),
        period = int.parse(json['period'].toString()),
        description = json['description'].toString();
}
