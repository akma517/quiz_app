import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hus_quiz/models/bookmarks.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/models/quiz_meta.dart';
import 'package:hus_quiz/models/test_history.dart';
import 'package:hus_quiz/services/bookmarks_service.dart';
import 'package:hus_quiz/services/quiz_meta_service.dart';
import 'package:hus_quiz/services/quiz_service.dart';
import 'package:hus_quiz/services/test_history_service.dart';

enum QuizMode { test, study, review, cancel, bookmarks }

class QuizProvider extends ChangeNotifier {
  final QuizService _quizService = QuizService();
  final QuizMetaService _quizMetaService = QuizMetaService();
  final TestHistoryService _testHistoryService = TestHistoryService();
  final BookmarksService _bookmarksService = BookmarksService();

  late List<Bookmarks> bookmarksList;
  late List<TestHistory> testHistories;
  late List<QuizMeta> quizMetas;
  late QuizMeta currentQuizMeta;
  late Bookmarks currentBookmarks;
  late TestHistory currentTestHistory;
  late int _score;
  List<Quiz> _quizs = [];
  late QuizMode _quizMode;
  late int _currentQuizIndex;
  late Timer _timer;
  int _testTime = 9999;
  bool _isKor = true;

  bool get isKor => _isKor;

  set isKor(bool isKor) {
    _isKor = isKor;
  }

  List<Quiz> get quizs => _quizs;
  QuizMode get quizMode => _quizMode;
  int get score => _score;
  int get currentQuizIndex => _currentQuizIndex;
  int get testTime => _testTime;
  QuizService get quizService => _quizService;
  QuizMetaService get quizMetaService => _quizMetaService;

  set quizs(List<Quiz> quizs) => _quizs = quizs;
  set quizMode(QuizMode quizMode) => _quizMode = quizMode;
  set score(int score) => _score = score;

  Future<bool> addTestHistory(
      String userId, int quizNo, String submissionYn) async {
    List<int> questionNoList = [];
    List<String> correctList = [];
    List<String> checkedList = [];
    List<int> questionScoreList = [];
    List<String> userAnswerList = [];

    if (submissionYn == "Y") {
      for (var i = 0; i < quizs.length; i++) {
        questionNoList.add(quizs[i].realQuestionNo);
        correctList.add(quizs[i].isCorrect ? "Y" : "N");
        checkedList.add(quizs[i].isChecked ? "Y" : "N");
        questionScoreList.add(quizs[i].score);
        userAnswerList.add(quizs[i].useranswer);
      }
    } else {
      for (var i = 0; i < quizs.length; i++) {
        questionNoList.add(quizs[i].realQuestionNo);
        correctList.add("N");
        checkedList.add("N");
        questionScoreList.add(quizs[i].score);
        userAnswerList.add(quizs[i].useranswer);
      }
    }

    TestHistory targetTestHistory = TestHistory(
      userId,
      quizNo,
      questionNoList,
      correctList,
      checkedList,
      questionScoreList,
      userAnswerList,
      submissionYn,
      score,
    );

    return await _testHistoryService.addTestHistory(targetTestHistory);
  }

  void setUserAnswer(bool isReplace, String answer, int index) {
    if (isReplace) {
      quizs[index].useranswer = quizs[index].useranswer.replaceAll(answer, "");
    } else {
      quizs[index].useranswer += answer;
    }
    notifyListeners();
  }

  void setCurrentQuizIndex(int quizIndex) {
    _currentQuizIndex = quizIndex;
    notifyListeners();
  }

  Future<bool> initQuizMetas() async {
    quizMetas = await _quizMetaService.getQuizMetas();
    return true;
  }

  Future<bool> initQuizs(String userId) async {
    if (quizMode == QuizMode.test) {
      isKor = true;
      _currentQuizIndex = 1;
      _score = 0;
      _quizs =
          await _quizService.getQuizs(quizMode, currentQuizMeta.quizNo, userId);
      _quizService.initQuizsScore(_quizs, currentQuizMeta);
      setTestTimeout();
    } else if (quizMode == QuizMode.study) {
      isKor = true;
      _currentQuizIndex = 1;
      _quizs =
          await _quizService.getQuizs(quizMode, currentQuizMeta.quizNo, userId);
    } else if (quizMode == QuizMode.review) {
      _currentQuizIndex = 1;
    } else if (quizMode == QuizMode.bookmarks) {
      _currentQuizIndex = 1;
    }
    return true;
  }

  bool submmitQuizs() {
    score = _quizService.calcQuizsScore(quizs);
    var isSolved = _quizService.checkAllSolved(quizs);
    return isSolved;
  }

  void timerCancel() {
    _timer.cancel();
  }

  void setTestTimeout() {
    _testTime = currentQuizMeta.testTime * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _testTime--;
      notifyListeners();
    });
  }

  void checkQuestion(int quizIndex) {
    quizs[quizIndex - 1].isChecked = !quizs[quizIndex - 1].isChecked;
    notifyListeners();
  }

  void translateLanguage() {
    isKor = !isKor;
    notifyListeners();
  }

  Future<bool> initTestHistories(String userId) async {
    quizMode = QuizMode.review;
    isKor = true;
    _currentQuizIndex = 1;

    testHistories = await _testHistoryService.getTestHistories(userId);
    if (testHistories.isEmpty) return true;
    var historyQuizs =
        await _quizService.getQuizs(quizMode, 0, userId); // 퀴즈 전체 가져오기

    for (var i = 0; i < testHistories.length; i++) {
      List<Quiz> tmpQuizs = [];
      List<Quiz> filteredQuizs = historyQuizs
          .where((quiz) => quiz.quizNo == testHistories[i].quizNo)
          .toList();
      for (var j = 0; j < testHistories[i].questionNoList.length; j++) {
        var tmpNo = testHistories[i].questionNoList[j] - 1;
        Quiz tmpQuiz = Quiz(
          historyQuizs[tmpNo].quizNo,
          j + 1,
          filteredQuizs[tmpNo].realQuestionNo,
          filteredQuizs[tmpNo].question_kor,
          filteredQuizs[tmpNo].question_eng,
          filteredQuizs[tmpNo].candidates_kor,
          filteredQuizs[tmpNo].candidates_eng,
          filteredQuizs[tmpNo].answer,
          testHistories[i].userAnswerList[j],
          testHistories[i].correctList[j] == "Y" ? true : false,
          testHistories[i].checkedList[j] == "Y" ? true : false,
          testHistories[i].questionScoreList[j],
          filteredQuizs[tmpNo].bookmarked,
        );
        tmpQuizs.add(tmpQuiz);
      }

      testHistories[i].quizs = tmpQuizs;
    }

    return true;
  }

  Future<bool> initBookmarks(String userId) async {
    quizMode = QuizMode.bookmarks;
    isKor = true;
    _currentQuizIndex = 1;

    bookmarksList = await _bookmarksService.getBookmarks(userId);
    if (bookmarksList.isEmpty) return true;
    var quizs = await _quizService.getQuizs(quizMode, 0, userId); // 퀴즈 전체 가져오기

    for (var i = 0; i < bookmarksList.length; i++) {
      List<Quiz> filteredQuizs = quizs
          .where((quiz) => quiz.quizNo == bookmarksList[i].quizNo)
          .where((quiz) => quiz.bookmarked == "Y")
          .toList();

      bookmarksList[i].quizs = filteredQuizs;
    }
    return true;
  }

  Future<bool> addBookmarkInStudy(
      int quizNo, int questionNo, String userId) async {
    bool success =
        await _bookmarksService.addBookmark(quizNo, questionNo, userId);

    if (success) {
      quizs[questionNo - 1].bookmarked = 'Y';
      notifyListeners();
    }

    return success;
  }

  Future<bool> removeBookmarkInStudy(
      int quizNo, int questionNo, String userId) async {
    bool success =
        await _bookmarksService.removeBookmark(quizNo, questionNo, userId);

    if (success) {
      quizs[questionNo - 1].bookmarked = 'N';
      notifyListeners();
    }

    return success;
  }

  Future<bool> addBookmarkInReview(
      int quizNo, int questionNo, String userId) async {
    bool success =
        await _bookmarksService.addBookmark(quizNo, questionNo, userId);

    if (success) {
      quizs
          .where((quiz) => quiz.realQuestionNo == questionNo)
          .toList()[0]
          .bookmarked = 'Y';
      currentTestHistory.quizs = quizs;
      notifyListeners();
    }

    return success;
  }

  Future<bool> removeBookmarkInReview(
      int quizNo, int questionNo, String userId) async {
    bool success =
        await _bookmarksService.removeBookmark(quizNo, questionNo, userId);

    if (success) {
      quizs
          .where((quiz) => quiz.realQuestionNo == questionNo)
          .toList()[0]
          .bookmarked = 'N';
      currentTestHistory.quizs = quizs;
      notifyListeners();
    }

    return success;
  }

  Future<bool> removeBookmarkInBookmarks(int quizNo, int realQuestionNo,
      int questionNo, String userId, bool popOut) async {
    bool success =
        await _bookmarksService.removeBookmark(quizNo, realQuestionNo, userId);

    if (success) {
      if (popOut == false) return success;

      quizs[questionNo - 1].bookmarked = 'N';
      quizs = quizs.where((quiz) => quiz.bookmarked == 'Y').toList();
      currentBookmarks.quizs = quizs;
      notifyListeners();
    }

    return success;
  }
}
