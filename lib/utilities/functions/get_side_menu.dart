import 'package:flutter/material.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/subscribe_provider.dart';
import 'package:hus_quiz/providers/system_log_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_plain_service_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_super_service_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_only_user_service_dialog.dart';
import 'package:provider/provider.dart';

List<Widget> getSideMenu(
    User user, BuildContext context, GlobalKey<ScaffoldState> scaffoldkey) {
  String userName = "${user.name}님";
  String userEmail = user.id;
  int userAuth = user.auth;
  Menu menu = Provider.of<MenuProvider>(context, listen: false).menu;
  String backgroundImage =
      user.auth > 0 ? "assets/images/whale2.png" : "assets/images/ico.png";

  var sideMenuList = <Widget>[];
  var rightColumn = <Widget>[];
  if (userAuth > 1) {
    rightColumn.addAll(
      [
        Text(
          "${user.subscribeName} 구독중",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Text(
          "구독만료 : ${user.endDate.substring(0, 4)}.${user.endDate.substring(4, 6)}.${user.endDate.substring(6, 8)}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
        Text(
          "결제예정 : ${user.endDate.substring(0, 4)}.${user.endDate.substring(4, 6)}.${user.endDate.substring(6, 8)}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  } else if (userAuth > 0) {
    rightColumn.addAll(
      [
        const Text(
          "구독하여",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const Text(
          "멋진 서비스를",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const Text(
          "누려봐요",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  } else {
    rightColumn.addAll(
      [
        const Text(
          "로그인해서",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const Text(
          "멋진 서비스를",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const Text(
          "누려봐요",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  sideMenuList.add(
    Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  minRadius: 37,
                  maxRadius: 37,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(backgroundImage),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rightColumn,
            ),
          ],
        ),
      ),
    ),
  );

  if (userAuth > 0) {
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [Menu.quiz, Menu.testHistory, Menu.bookmarks]
            .any((element) => menu == element),
        leading: const Icon(
          Icons.quiz,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          '퀴즈',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            title: Text(
              '문제풀기',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.quiz ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              getLoadingDialog(context);
              Provider.of<QuizProvider>(context, listen: false)
                  .initQuizMetas()
                  .then(
                (value) {
                  Navigator.pop(context);
                  Provider.of<MenuProvider>(context, listen: false)
                      .setSideMenuTitle(Menu.quiz);
                  scaffoldkey.currentState?.closeDrawer();
                },
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              '시험이력',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.testHistory ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              if (user.auth < 3) {
                getOnlySuperServiceDialog(context);
              } else {
                getLoadingDialog(context);
                Provider.of<QuizProvider>(context, listen: false)
                    .initTestHistories(user.id)
                    .then(
                  (value) {
                    Navigator.pop(context);
                    Provider.of<MenuProvider>(context, listen: false)
                        .setSideMenuTitle(Menu.testHistory);
                    scaffoldkey.currentState?.closeDrawer();
                  },
                );
              }
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              '북마크',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.bookmarks ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              if (user.auth < 2) {
                getOnlyPlainServiceDialog(context);
              } else {
                getLoadingDialog(context);
                Provider.of<QuizProvider>(context, listen: false)
                    .initBookmarks(user.id)
                    .then(
                  (value) {
                    Navigator.pop(context);
                    Provider.of<MenuProvider>(context, listen: false)
                        .setSideMenuTitle(Menu.bookmarks);
                    scaffoldkey.currentState?.closeDrawer();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [Menu.questionComplain, Menu.systemComplain]
            .any((element) => menu == element),
        leading: const Icon(
          Icons.question_answer,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          'Q&A',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            title: Text(
              '문제건의',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    menu == Menu.questionComplain ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              if (user.auth < 1) {
                getOnlyUserServiceDialog(context);
              } else {
                getLoadingDialog(context);
                Provider.of<BoardProvider>(context, listen: false)
                    .boardCategory = BoardCategory.questionComplain;
                Provider.of<BoardProvider>(context, listen: false)
                    .initBoardList()
                    .then(
                  (value) {
                    Navigator.pop(context);
                    Provider.of<MenuProvider>(context, listen: false)
                        .setSideMenuTitle(Menu.questionComplain);
                    scaffoldkey.currentState?.closeDrawer();
                  },
                );
              }
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              '오류및개선',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    menu == Menu.systemComplain ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              if (user.auth < 1) {
                getOnlyUserServiceDialog(context);
              } else {
                getLoadingDialog(context);
                Provider.of<BoardProvider>(context, listen: false)
                    .boardCategory = BoardCategory.systemComplain;
                Provider.of<BoardProvider>(context, listen: false)
                    .initBoardList()
                    .then(
                  (value) {
                    Navigator.pop(context);
                    Provider.of<MenuProvider>(context, listen: false)
                        .setSideMenuTitle(Menu.systemComplain);
                    scaffoldkey.currentState?.closeDrawer();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [Menu.subscribeProducts, Menu.subscribeMangement]
            .any((element) => menu == element),
        leading: const Icon(
          Icons.subscriptions,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          '구독',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            title: Text(
              '구독상품',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.subscribeProducts
                    ? Colors.blue.shade400
                    : null,
              ),
            ),
            onTap: () {
              getLoadingDialog(context);
              Provider.of<SubscribeProvider>(context, listen: false)
                  .initSubscribeProducts()
                  .then(
                (value) {
                  Provider.of<SubscribeProvider>(context, listen: false)
                      .getSubscribeState(user.id)
                      .then((value) {
                    Navigator.pop(context);
                    Provider.of<MenuProvider>(context, listen: false)
                        .setSideMenuTitle(Menu.subscribeProducts);
                    scaffoldkey.currentState?.closeDrawer();
                  });
                },
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              '구독관리',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.subscribeMangement
                    ? Colors.blue.shade400
                    : null,
              ),
            ),
            onTap: () {
              getLoadingDialog(context);
              Provider.of<SubscribeProvider>(context, listen: false)
                  .getSubscribeState(user.id)
                  .then(
                (value) {
                  Navigator.pop(context);
                  Provider.of<MenuProvider>(context, listen: false)
                      .setSideMenuTitle(Menu.subscribeMangement);
                  scaffoldkey.currentState?.closeDrawer();
                },
              );
            },
          ),
        ],
      ),
    );
  } else {
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [Menu.quiz, Menu.testHistory, Menu.bookmarks]
            .any((element) => menu == element),
        leading: const Icon(
          Icons.quiz,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          '퀴즈',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            title: Text(
              '문제풀기',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.quiz ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              scaffoldkey.currentState?.closeDrawer();
            },
          ),
          const Divider(height: 1),
          ListTile(
            enabled: false,
            title: const Text(
              '시험이력',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            enabled: false,
            title: const Text(
              '북마크',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [Menu.questionComplain, Menu.systemComplain]
            .any((element) => menu == element),
        leading: const Icon(
          Icons.question_answer,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          'Q&A',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            enabled: false,
            title: const Text(
              '문제건의',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            enabled: false,
            title: const Text(
              '오류및개선',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [Menu.subscribeProducts, Menu.subscribeMangement]
            .any((element) => menu == element),
        leading: const Icon(
          Icons.subscriptions,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          '구독',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            enabled: false,
            title: const Text(
              '구독상품',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            enabled: false,
            title: const Text(
              '구독관리',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  if (userAuth >= 99) {
    sideMenuList.add(
      ExpansionTile(
        initiallyExpanded: [
          Menu.loginLog,
          Menu.testLog,
          Menu.subscribeLog,
          Menu.loginCnt
        ].any((element) => menu == element),
        leading: const Icon(
          Icons.settings,
        ),
        trailing: const Icon(Icons.add),
        title: const Text(
          '시스템로그',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.white,
        children: <Widget>[
          const Divider(height: 1),
          ListTile(
            title: Text(
              '로그인로그',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.loginLog ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              getLoadingDialog(context);
              Provider.of<SystemLogProvider>(context, listen: false)
                  .initSystemLog("login")
                  .then((value) {
                Provider.of<MenuProvider>(context, listen: false)
                    .setSideMenuTitle(Menu.loginLog);
                Navigator.pop(context);
                scaffoldkey.currentState?.closeDrawer();
              });
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              '로그인횟수',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.loginCnt ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              getLoadingDialog(context);
              Provider.of<SystemLogProvider>(context, listen: false)
                  .initSystemLog("login_cnt")
                  .then((value) {
                Provider.of<MenuProvider>(context, listen: false)
                    .setSideMenuTitle(Menu.loginCnt);
                Navigator.pop(context);
                scaffoldkey.currentState?.closeDrawer();
              });
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              '시험로그',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: menu == Menu.testLog ? Colors.blue.shade400 : null,
              ),
            ),
            onTap: () {
              getLoadingDialog(context);
              Provider.of<SystemLogProvider>(context, listen: false)
                  .initSystemLog("test")
                  .then((value) {
                Provider.of<MenuProvider>(context, listen: false)
                    .setSideMenuTitle(Menu.testLog);
                Navigator.pop(context);
                scaffoldkey.currentState?.closeDrawer();
              });
            },
          ),

          // ListTile(
          //   title: Text(
          //     '구독로그',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: menu == Menu.subscribeLog ? Colors.blue.shade400 : null,
          //     ),
          //   ),
          //   onTap: () {
          //     Provider.of<MenuProvider>(context, listen: false)
          //         .setSideMenuTitle(Menu.subscribeLog);
          //     scaffoldkey.currentState?.closeDrawer();
          //   },
          // ),const Divider(height: 1),
        ],
      ),
    );
  }

  return sideMenuList;
}
