class SubscribeState {
  int subscribeNo;
  late String subscribeName;
  late String subscribePeriodName;
  late int price;
  late int period;
  late String description;
  late String startDate;
  late String endDate;
  late String paymentDate;
  late String continueYn;

  SubscribeState.noSubscribe(this.subscribeNo);

  SubscribeState.fromJson(Map<String, dynamic> json)
      : subscribeNo = int.parse(json['subscribe_no'].toString()),
        subscribeName = json['subscribe_name'].toString(),
        subscribePeriodName = json['subscribe_period_name'].toString(),
        price = int.parse(json['price'].toString()),
        period = int.parse(json['period'].toString()),
        description = json['description'].toString(),
        startDate = json['start_date'].toString(),
        endDate = json['end_date'].toString(),
        paymentDate = json['payment_date'].toString(),
        continueYn = json['continue_yn'].toString();
}
