import 'package:flutter/material.dart';
import 'package:hus_quiz/models/board.dart';
import 'package:hus_quiz/models/quiz_meta.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/utilities/functions/get_appbar.dart';
import 'package:hus_quiz/utilities/functions/get_contents.dart';
import 'package:hus_quiz/utilities/functions/get_create_board_bottom_sheet.dart';
import 'package:hus_quiz/utilities/functions/get_side_menu.dart';
import 'package:hus_quiz/utilities/functions/get_user_popupmenu_list.dart';
import 'package:provider/provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    List<QuizMeta> quizMetas =
        Provider.of<QuizProvider>(context, listen: false).quizMetas;
    User user = Provider.of<UserProvider>(context, listen: false).user;
    String userName = "${user.name}님";
    GlobalKey<ScaffoldState> sacffoldkey = GlobalKey<ScaffoldState>();
    List<PopupMenuEntry<UserMenu>> list = getUserPopupMenu(user);
    List<Widget> sideMenu = getSideMenu(user, context, sacffoldkey);

    String menuTitle = Provider.of<MenuProvider>(
      context,
    ).menuTitle;

    Widget? contents = getContents(context, height, quizMetas, width);

    return Scaffold(
        key: sacffoldkey,
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          width: 250,
          backgroundColor: Colors.white,
          child: ListView(
            children: sideMenu,
          ),
        ),
        appBar: getAppBar(menuTitle, userName, context, width, height, list),
        body: contents,
        floatingActionButton: <Menu>[
          Menu.questionComplain,
          Menu.systemComplain
        ].contains(Provider.of<MenuProvider>(context, listen: false).menu)
            ? FloatingActionButton(
                child: Icon(Icons.create),
                onPressed: () {
                  getCreateBoardBottomSheet(context, width, height);
                },
              )
            : SizedBox());
  }
}
