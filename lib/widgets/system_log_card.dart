import 'package:flutter/material.dart';
import 'package:hus_quiz/models/system_log.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/system_log_provider.dart';
import 'package:provider/provider.dart';

class SystemLogCard extends StatelessWidget {
  const SystemLogCard({
    Key? key,
    required this.height,
    required this.width,
    required this.index,
  }) : super(key: key);

  final double height;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    SystemLog systemLog = Provider.of<SystemLogProvider>(context, listen: false)
        .systemLogs[index];

    String log = "";
    if (Menu.loginLog ==
        Provider.of<MenuProvider>(context, listen: false).menu) {
      log =
          "${systemLog.userId} | 로그인일자 : ${systemLog.loginDate.substring(0, 4)}년 ${systemLog.loginDate.substring(4, 6)}월 ${systemLog.loginDate.substring(6, 8)}일 ${systemLog.loginDate.substring(8, 10)}시 ${systemLog.loginDate.substring(10, 12)}분 ${systemLog.loginDate.substring(12, 14)}초";
    } else if (Menu.testLog ==
        Provider.of<MenuProvider>(context, listen: false).menu) {
      log =
          "${systemLog.userId} | 시험응시일자 : ${systemLog.testDate.substring(0, 4)}년 ${systemLog.testDate.substring(4, 6)}월 ${systemLog.testDate.substring(6, 8)}일 ${systemLog.testDate.substring(8, 10)}시 ${systemLog.testDate.substring(10, 12)}분 ${systemLog.testDate.substring(12, 14)}초";
    } else if (Menu.loginCnt ==
        Provider.of<MenuProvider>(context, listen: false).menu) {
      log = "${systemLog.userId} | 로그인횟수 : ${systemLog.cnt}회";
    }
    return Card(
      shape: const BeveledRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: height * 0.015,
              fontWeight: FontWeight.bold,
            ),
            log,
          ),
        ),
      ),
    );
  }
}
