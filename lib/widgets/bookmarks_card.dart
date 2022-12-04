import 'package:flutter/material.dart';
import 'package:hus_quiz/models/bookmarks.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../screens/quiz_screen.dart';
import '../providers/quiz_provider.dart';

class BookmarksCard extends StatelessWidget {
  const BookmarksCard({
    Key? key,
    required this.height,
    required this.bookmarks,
  }) : super(key: key);

  final double height;
  final Bookmarks bookmarks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: height * 0.6,
      child: SizedBox(
        height: height * 0.45,
        child: Card(
          color: Colors.blue.shade100,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: SizedBox(
                    width: height * 0.2,
                    height: height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(bookmarks.imagePath),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                bookmarks.quizName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        color: Colors.orange.shade300,
                        child: TextButton(
                          onPressed: () {
                            Provider.of<QuizProvider>(context, listen: false)
                                .quizMode = QuizMode.bookmarks;
                            Provider.of<QuizProvider>(context, listen: false)
                                .quizs = bookmarks.quizs;
                            Provider.of<QuizProvider>(context, listen: false)
                                .currentBookmarks = bookmarks;
                            Provider.of<QuizProvider>(context, listen: false)
                                .initQuizs(Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user
                                    .id)
                                .then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const QuizScreen();
                                      },
                                    ),
                                  ),
                                );
                          },
                          child: Text(
                            "  북마크 문제 확인  ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.027,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
