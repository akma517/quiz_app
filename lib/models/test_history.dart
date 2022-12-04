import 'package:hus_quiz/models/quiz.dart';

class TestHistory {
  late int testHistoryNo;
  String userId;
  int quizNo;
  List<int> questionNoList;
  List<String> correctList;
  List<String> checkedList;
  List<int> questionScoreList;
  List<String> userAnswerList;
  int testScore;
  String submissionYn;
  late String testDate;
  late List<Quiz> quizs;
  late String imagePath;
  late String quizName;
  late int passScore;

  TestHistory(
    this.userId,
    this.quizNo,
    this.questionNoList,
    this.correctList,
    this.checkedList,
    this.questionScoreList,
    this.userAnswerList,
    this.submissionYn,
    this.testScore,
  );

  TestHistory.fromJson(Map<String, dynamic> json)
      : testHistoryNo = int.parse(json['test_history_no'].toString()),
        userId = json['user_id'].toString(),
        quizNo = int.parse(json['quiz_no'].toString()),
        questionNoList = json['question_no_group']
            .toString()
            .split(',')
            .map((e) => int.parse(e))
            .toList(),
        correctList = json['correct_group'].toString().split(','),
        checkedList = json['checked_group'].toString().split(','),
        questionScoreList = json['question_score_group']
            .toString()
            .split(',')
            .map((e) => int.parse(e))
            .toList(),
        testScore = int.parse(json['test_score'].toString()),
        userAnswerList = json['user_answer_group'].toString().split(','),
        submissionYn = json['submission_yn'].toString(),
        testDate = json['test_date'].toString(),
        imagePath = json['image_path'].toString(),
        quizName = json['quiz_name'].toString(),
        passScore = int.parse(json['pass_score'].toString());

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'quiz_no': quizNo,
        'question_no_group':
            questionNoList.toString().replaceAll(RegExp(r'[\][\s+]'), ''),
        'correct_group':
            correctList.toString().replaceAll(RegExp(r'[\][\s+]'), ''),
        'checked_group':
            checkedList.toString().replaceAll(RegExp(r'[\][\s+]'), ''),
        'question_score_group':
            questionScoreList.toString().replaceAll(RegExp(r'[\][\s+]'), ''),
        'user_answer_group':
            userAnswerList.toString().replaceAll(RegExp(r'[\][\s+]'), ''),
        'test_score': testScore,
        'submission_yn': submissionYn,
      };
}
