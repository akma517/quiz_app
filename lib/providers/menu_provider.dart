import 'package:flutter/material.dart';

enum Menu {
  quiz,
  testHistory,
  bookmarks,
  questionComplain,
  systemComplain,
  subscribeProducts,
  subscribeMangement,
  loginLog,
  testLog,
  subscribeLog,
  loginCnt
}

class MenuProvider extends ChangeNotifier {
  late Menu menu;
  late String menuTitle;

  Map<Menu, String> menuMap = {
    Menu.quiz: "문제풀기",
    Menu.testHistory: "시험이력",
    Menu.bookmarks: "북마크",
    Menu.questionComplain: "문제건의",
    Menu.systemComplain: "오류및개선",
    Menu.subscribeProducts: "구독상품",
    Menu.subscribeMangement: "구독관리",
    Menu.loginLog: "로그인로그",
    Menu.testLog: "시험로그",
    Menu.subscribeLog: "구독로그",
    Menu.loginCnt: "로그인횟수"
  };

  setMenuTitle(Menu targetMenu) {
    menu = targetMenu;
    menuTitle = menuMap[menu]!;
    //notifyListeners();
  }

  setSideMenuTitle(Menu targetMenu) {
    menu = targetMenu;
    menuTitle = menuMap[menu]!;
    notifyListeners();
  }
}
