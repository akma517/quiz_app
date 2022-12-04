import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/screens/quiz_screen.dart';
import 'package:provider/provider.dart';
import 'package:hus_quiz/models/quiz.dart';
import 'package:hus_quiz/screens/home_screen.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    Key? key,
    required this.height,
    required this.score,
    required this.quzis,
    required this.isPassed,
  }) : super(key: key);

  final double height;
  final int score;
  final List<Quiz> quzis;
  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    String subComment = isPassed ? "축하드립니다" : "아쉽습니다";

    String mainComment = isPassed
        ? "귀하의 점수는 $score점으로\n본 시험에 합격하셨습니다."
        : "귀하의 점수는 $score점으로\n본 시험에 불합격하셨습니다.";
    Color color = isPassed ? Colors.green.shade300 : Colors.red.shade300;
    Color buttonColorConfirm = Colors.blue.shade300;
    Color buttonColorBack = Colors.blue.shade300;

    return Container(
      padding: const EdgeInsets.all(8.0),
      height: height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        height: height * 0.45,
        child: Card(
          color: color,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                textAlign: TextAlign.center,
                subComment,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                mainComment,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.07,
                child: Card(
                  color: buttonColorConfirm,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      Provider.of<QuizProvider>(context, listen: false)
                          .quizMode = QuizMode.review;
                      Provider.of<QuizProvider>(context, listen: false)
                          .initQuizs(
                              Provider.of<UserProvider>(context, listen: false)
                                  .user
                                  .id)
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
                    child: Text(
                      "결과확인",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.07,
                child: Card(
                  color: buttonColorBack,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            Provider.of<MenuProvider>(context, listen: false)
                                .setMenuTitle(Menu.quiz);
                            return const HomeScreen();
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "돌아가기",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
