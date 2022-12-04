import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/subscribe_provider.dart';
import 'package:hus_quiz/providers/system_log_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/providers/valid_provider.dart';
import 'package:hus_quiz/screens/init_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubscribeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BoardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ValidProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SystemLogProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'hus quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const InitScreen(),
      ),
    );
  }
}
