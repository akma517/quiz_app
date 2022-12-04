class Quiz {
  late int quizNo;
  late int _questionNo;
  late int realQuestionNo;
  String question_kor;
  String question_eng;
  List<String> candidates_kor;
  List<String> candidates_eng;
  String answer;
  String _useranswer = "";
  String bookmarked;
  late bool _isCorrect;
  late bool _isChecked = false;
  late int _score;

  Quiz(
    this.quizNo,
    this._questionNo,
    this.realQuestionNo,
    this.question_kor,
    this.question_eng,
    this.candidates_kor,
    this.candidates_eng,
    this.answer,
    this._useranswer,
    this._isCorrect,
    this._isChecked,
    this._score,
    this.bookmarked,
  );

  String get useranswer => _useranswer;
  set useranswer(String useranswer) {
    _useranswer = useranswer;
    if (_useranswer.length > 1) {
      List<int> asciiUseranswer = _useranswer.runes.toList();
      asciiUseranswer.sort((a, b) => a.compareTo(b));
      _useranswer = String.fromCharCodes(asciiUseranswer);
    }
  }

  bool get isCorrect => _isCorrect;
  set isCorrect(bool isCorrect) => _isCorrect = isCorrect;
  bool get isChecked => _isChecked;
  set isChecked(bool isChecked) => _isChecked = isChecked;
  int get score => _score;
  set score(score) => _score = score;
  int get questionId => _questionNo;
  set questionId(questionNo) => _questionNo = questionNo;
  // int get realQuestionId => _realQuestionId;
  // set realQuestionId(realQuestionId) => _realQuestionId = realQuestionId;

  Quiz.fromJson(Map<String, dynamic> json)
      : quizNo = int.parse(json['quiz_no'].toString()),
        question_kor = json['question_kor'].toString(),
        question_eng = json['question'].toString(),
        candidates_kor = [
          json['a_kor'].toString(),
          json['b_kor'].toString(),
          json['c_kor'].toString(),
          json['d_kor'].toString(),
          json['e_kor'].toString(),
          json['f_kor'].toString(),
          json['g_kor'].toString(),
        ],
        candidates_eng = [
          json['a'].toString(),
          json['b'].toString(),
          json['c'].toString(),
          json['d'].toString(),
          json['e'].toString(),
          json['f'].toString(),
          json['g'].toString(),
        ],
        answer = json['answer'].toString(),
        realQuestionNo = int.parse(json['question_no'].toString()),
        bookmarked = json['bookmarked'].toString();
}
