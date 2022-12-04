import 'package:flutter/material.dart';
import 'package:hus_quiz/models/system_log.dart';
import 'package:hus_quiz/services/system_log_service.dart';

class SystemLogProvider extends ChangeNotifier {
  late List<SystemLog> systemLogs;

  SystemLogService systemLogService = SystemLogService();

  Future<bool> initSystemLog(String option) async {
    systemLogs = await systemLogService.getLogs(option);

    return true;
  }
}
