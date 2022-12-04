class QuizMeta {
  int quizNo;
  String quizName;
  int testTime;
  int testQuestionCount;
  int totalScore;
  int passScore;
  String imagePath;
  String zeroScoreYn;
  String questionScores;
  String questionScoreCounts;

  QuizMeta.fromMap(Map<String, dynamic> map)
      : quizNo = map['quiz_no'],
        quizName = map['quiz_name'],
        testTime = map['test_time'],
        testQuestionCount = map['test_question_count'],
        totalScore = map['total_score'],
        passScore = map['pass_score'],
        imagePath = map['image_path'],
        zeroScoreYn = map['zero_score_yn'],
        questionScores = map['question_scores'],
        questionScoreCounts = map['question_score_counts'];

  QuizMeta.fromJson(Map<String, dynamic> json)
      : quizNo = int.parse(json['quiz_no'].toString()),
        quizName = json['quiz_name'].toString(),
        testTime = int.parse(json['test_time'].toString()),
        testQuestionCount = int.parse(json['test_question_count'].toString()),
        totalScore = int.parse(json['total_score'].toString()),
        passScore = int.parse(json['pass_score'].toString()),
        imagePath = json['image_path'].toString(),
        zeroScoreYn = json['zero_score_yn'].toString(),
        questionScores = json['question_scores'].toString(),
        questionScoreCounts = json['question_score_counts'].toString();
}
