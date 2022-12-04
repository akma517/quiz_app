import 'package:flutter/material.dart';
import 'package:hus_quiz/models/subscribe_state.dart';
import 'package:hus_quiz/providers/subscribe_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/utilities/functions/get_only_no_kico_subscribe_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_subscribe_state.dart';
import 'package:provider/provider.dart';

class SubscribeManageCard extends StatelessWidget {
  const SubscribeManageCard({
    Key? key,
    required this.height,
    required this.subscribeState,
  }) : super(key: key);

  final double height;
  final SubscribeState subscribeState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      height: height * 0.75,
      child: SizedBox(
        height: height * 0.4,
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 6.0, color: Colors.blue.shade100),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    subscribeState.subscribeName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Divider(thickness: 2, color: Colors.blue.shade100),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      subscribeState.description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              getSubscribeState(context, subscribeState),
              SizedBox(
                height: height * 0.07,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  color: subscribeState.continueYn == "Y"
                      ? Colors.red.shade300
                      : Colors.green.shade300,
                  child: TextButton(
                    onPressed: () {
                      if (Provider.of<SubscribeProvider>(context, listen: false)
                              .subscribeState
                              .subscribeNo ==
                          7) {
                        getOnlyNoKicoSubscribeDialog(context);
                      } else {}
                      // Provider.of<QuizProvider>(context, listen: false)
                      //     .quizMode = QuizMode.bookmarks;
                      // Provider.of<QuizProvider>(context, listen: false)
                      //     .quizs = bookmarks.quizs;
                      // Provider.of<QuizProvider>(context, listen: false)
                      //     .currentBookmarks = bookmarks;
                      // Provider.of<QuizProvider>(context, listen: false)
                      //     .initQuizs(Provider.of<UserProvider>(context,
                      //             listen: false)
                      //         .user
                      //         .id)
                      //     .then(
                      //       (value) => Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) {
                      //             return const QuizScreen();
                      //           },
                      //         ),
                      //       ),
                      //     );
                    },
                    child: Text(
                      subscribeState.continueYn == "Y"
                          ? "  구독취소  "
                          : "  구독연장  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height * 0.03,
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
