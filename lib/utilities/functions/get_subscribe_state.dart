import 'package:flutter/material.dart';
import 'package:hus_quiz/models/subscribe_state.dart';
import 'package:intl/intl.dart';

Row getSubscribeState(context, SubscribeState subscribeState) {
  Size screenSize = MediaQuery.of(context).size;
  double height = screenSize.height;
  List<Widget> column = [];

  column.add(
    SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            '${subscribeState.subscribePeriodName}',
            style: TextStyle(
              color: Colors.black,
              fontSize: height * 0.02,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            '${subscribeState.period}일',
            style: TextStyle(
              color: Colors.black,
              fontSize: height * 0.0185,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            '₩${NumberFormat('###,###,###').format(subscribeState.price)}',
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: height * 0.0165,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.center,
                '구독시작일자: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.0165,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                '${subscribeState.startDate.substring(0, 4)}.${subscribeState.startDate.substring(4, 6)}.${subscribeState.startDate.substring(6, 8)}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.0165,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.center,
                '구독만료일자: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.0165,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                '${subscribeState.endDate.substring(0, 4)}.${subscribeState.endDate.substring(4, 6)}.${subscribeState.endDate.substring(6, 8)}',
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: height * 0.0165,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subscribeState.continueYn == "Y"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      '다음결제일자: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height * 0.0165,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      '${subscribeState.paymentDate.substring(0, 4)}.${subscribeState.paymentDate.substring(4, 6)}.${subscribeState.paymentDate.substring(6, 8)}',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: height * 0.0165,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    ),
  );
  // if (i != subscribes.length - 1) {
  //   column.add(VerticalDivider(thickness: 2, color: Colors.blue.shade100));
  // }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: column,
  );
}
