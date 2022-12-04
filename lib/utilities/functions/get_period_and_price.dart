import 'package:flutter/material.dart';
import 'package:hus_quiz/models/subscribe.dart';
import 'package:intl/intl.dart';

Row getPeriodAndPrice(context, List<Subscribe> subscribes) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  double height = screenSize.height;
  List<Widget> column = [];
  for (var i = 0; i < subscribes.length; i++) {
    column.add(
      SizedBox(
        width: width * 0.28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              '${subscribes[i].subscribePeriodName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              '${subscribes[i].period}일',
              style: TextStyle(
                color: Colors.black,
                fontSize: height * 0.0185,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              '₩${NumberFormat('###,###,###').format(subscribes[i].price)}',
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: height * 0.0165,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    // if (i != subscribes.length - 1) {
    //   column.add(VerticalDivider(thickness: 2, color: Colors.blue.shade100));
    // }
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: column,
  );
}
