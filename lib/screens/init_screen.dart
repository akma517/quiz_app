import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/screens/home_screen.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_login_dialog.dart';
import 'package:provider/provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            getLoadingDialog(context);
            // getLoginDialog(context, width, height);
            Provider.of<UserProvider>(context, listen: false).autologin().then(
              (isAuto) {
                if (isAuto) {
                  Provider.of<QuizProvider>(context, listen: false)
                      .initQuizMetas()
                      .then(
                        (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              Provider.of<MenuProvider>(context, listen: false)
                                  .setMenuTitle(Menu.quiz);
                              return const HomeScreen();
                            },
                          ),
                          (route) => false,
                        ),
                      );
                } else {
                  Navigator.pop(context);
                  getLoginDialog(context, width, height);
                }
              },
            );
          },
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/splash.png',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: height * 0.8,
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 1200),
              repeatForever: true,
              animatedTexts: [
                FadeAnimatedText(
                  "tap to start",
                  textAlign: TextAlign.center,
                  duration: const Duration(milliseconds: 2500),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
