import 'package:flutter/material.dart';
import 'package:hus_quiz/models/test_history.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../screens/quiz_screen.dart';
import '../providers/quiz_provider.dart';

class TestHistoryCard extends StatelessWidget {
  const TestHistoryCard({
    Key? key,
    required this.height,
    required this.width,
    required this.testHistory,
  }) : super(key: key);

  final double height;
  final double width;
  final TestHistory testHistory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<QuizProvider>(context, listen: false).quizMode =
            QuizMode.review;
        Provider.of<QuizProvider>(context, listen: false).quizs =
            testHistory.quizs;
        Provider.of<QuizProvider>(context, listen: false).currentTestHistory =
            testHistory;
        Provider.of<QuizProvider>(context, listen: false)
            .initQuizs(
                Provider.of<UserProvider>(context, listen: false).user.id)
            .then(
          (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const QuizScreen();
                },
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: SizedBox(
          height: height * 0.15,
          width: width,
          child: Card(
            color: testHistory.testScore > testHistory.passScore
                ? Colors.green.shade200
                : Colors.red.shade200,
            elevation: 5,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(50),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  testHistory.quizName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "${testHistory.testDate.substring(0, 4)}년 ${testHistory.testDate.substring(4, 6)}월 ${testHistory.testDate.substring(6, 8)}일 ${testHistory.testDate.substring(8, 10)}시 ${testHistory.testDate.substring(10, 12)}분",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "총점 : ${testHistory.testScore}점 | 시험결과 : ${testHistory.testScore > testHistory.passScore ? '합격' : '불합격'} | 제출여부 : ${testHistory.submissionYn == 'Y' ? '제출' : '취소'}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
