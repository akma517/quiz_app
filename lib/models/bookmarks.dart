import 'package:hus_quiz/models/quiz.dart';

class Bookmarks {
  int quizNo;
  late List<Quiz> quizs;
  String imagePath;
  String quizName;

  Bookmarks(
    this.quizNo,
    this.quizName,
    this.imagePath,
  );

  Bookmarks.fromJson(Map<String, dynamic> json)
      : quizNo = int.parse(json['quiz_no'].toString()),
        imagePath = json['image_path'].toString(),
        quizName = json['quiz_name'].toString();
}
