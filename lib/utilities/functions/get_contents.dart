import 'package:flutter/material.dart';
import 'package:hus_quiz/models/board.dart';
import 'package:hus_quiz/models/quiz_meta.dart';
import 'package:hus_quiz/models/subscribe_state.dart';
import 'package:hus_quiz/models/system_log.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/quiz_provider.dart';
import 'package:hus_quiz/providers/subscribe_provider.dart';
import 'package:hus_quiz/providers/system_log_provider.dart';
import 'package:hus_quiz/widgets/board_card.dart';
import 'package:hus_quiz/widgets/subscribe_card.dart';
import 'package:hus_quiz/widgets/bookmarks_card.dart';
import 'package:hus_quiz/widgets/quiz_card.dart';
import 'package:hus_quiz/widgets/subscribe_manage_card.dart';
import 'package:hus_quiz/widgets/system_log_card.dart';
import 'package:hus_quiz/widgets/test_history_card.dart';
import 'package:provider/provider.dart';

Widget? getContents(BuildContext context, double height,
    List<QuizMeta> quizMetas, double width) {
  Menu currentMenu = Provider.of<MenuProvider>(
    context,
  ).menu;

  int contentsLength;
  Widget? contents;

  if (Menu.quiz == currentMenu) {
    contentsLength =
        Provider.of<QuizProvider>(context, listen: false).quizMetas.length;
    contents = contentsLength == 1
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuizCard(height: height, quizMeta: quizMetas[0]),
            ],
          )
        : ListView.builder(
            itemCount: contentsLength,
            itemBuilder: (context, index) {
              return QuizCard(height: height, quizMeta: quizMetas[index]);
            },
          );
  } else if (Menu.testHistory == currentMenu) {
    contentsLength =
        Provider.of<QuizProvider>(context, listen: false).testHistories.length;
    contents = contentsLength == 0
        ? Center(
            child: Text(
              "시험이력이 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : ListView.builder(
            itemCount: contentsLength,
            itemBuilder: (context, index) {
              return TestHistoryCard(
                  height: height,
                  width: width,
                  testHistory: Provider.of<QuizProvider>(context, listen: false)
                      .testHistories[index]);
            },
          );
  } else if (Menu.bookmarks == currentMenu) {
    contentsLength =
        Provider.of<QuizProvider>(context, listen: false).bookmarksList.length;
    contents = contentsLength == 0
        ? Center(
            child: Text(
              "북마크한 문제가 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : contentsLength == 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BookmarksCard(
                    height: height,
                    bookmarks: Provider.of<QuizProvider>(context, listen: false)
                        .bookmarksList[0],
                  ),
                ],
              )
            : ListView.builder(
                itemCount: contentsLength,
                itemBuilder: (context, index) {
                  return BookmarksCard(
                    height: height,
                    bookmarks: Provider.of<QuizProvider>(context, listen: false)
                        .bookmarksList[index],
                  );
                },
              );
  } else if (Menu.subscribeProducts == currentMenu) {
    contentsLength = Provider.of<SubscribeProvider>(context, listen: false)
        .subscribesByProdcut
        .length;
    contents = contentsLength == 0
        ? Center(
            child: Text(
              "구독상품이 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : contentsLength == 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SubscribeCard(
                    height: height,
                    subscribes:
                        Provider.of<SubscribeProvider>(context, listen: false)
                            .subscribesByProdcut[0],
                  ),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8.0),
                itemCount: contentsLength,
                itemBuilder: (context, index) {
                  return SubscribeCard(
                    height: height,
                    subscribes:
                        Provider.of<SubscribeProvider>(context, listen: false)
                            .subscribesByProdcut[index],
                  );
                },
              );
  } else if (Menu.subscribeMangement == currentMenu) {
    SubscribeState subscribeState =
        Provider.of<SubscribeProvider>(context, listen: false).subscribeState;
    contents = subscribeState.subscribeNo == 0
        ? Center(
            child: Text(
              "구독중인 상품이 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SubscribeManageCard(
                height: height,
                subscribeState: subscribeState,
              ),
            ],
          );
  } else if (Menu.questionComplain == currentMenu) {
    List<Board> boardList = Provider.of<BoardProvider>(context).boardList;
    int contentsLength = boardList.length;

    contents = contentsLength == 0
        ? Center(
            child: Text(
              "등록된 게시글이 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : ListView.builder(
            itemCount: contentsLength,
            itemBuilder: (context, index) {
              return BoardCard(
                height: height,
                width: width,
                index: index,
              );
            },
          );
  } else if (Menu.systemComplain == currentMenu) {
    List<Board> boardList = Provider.of<BoardProvider>(context).boardList;
    int contentsLength = boardList.length;

    contents = contentsLength == 0
        ? Center(
            child: Text(
              "등록된 게시글이 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : ListView.builder(
            itemCount: contentsLength,
            itemBuilder: (context, index) {
              return BoardCard(
                height: height,
                width: width,
                index: index,
              );
            },
          );
  } else if ([Menu.loginLog, Menu.testLog, Menu.loginCnt]
      .contains(currentMenu)) {
    List<SystemLog> systemLogs =
        Provider.of<SystemLogProvider>(context).systemLogs;
    int contentsLength = systemLogs.length;

    contents = contentsLength == 0
        ? Center(
            child: Text(
              "로그가 없습니다.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
            ),
          )
        : ListView.builder(
            itemCount: contentsLength,
            itemBuilder: (context, index) {
              return SystemLogCard(
                height: height,
                width: width,
                index: index,
              );
            },
          );
  }
  return contents;
}
