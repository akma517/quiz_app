import 'package:flutter/material.dart';
import 'package:hus_quiz/models/board.dart';
import 'package:hus_quiz/models/comment.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/providers/valid_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_manage_popupmenu_list.dart';
import 'package:hus_quiz/utilities/functions/get_modify_board_bottom_sheet.dart';
import 'package:hus_quiz/widgets/comment_card.dart';

import 'package:provider/provider.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    double height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    double width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    User user = Provider.of<UserProvider>(context, listen: false).user;
    List<PopupMenuEntry<ManageMenu>> list = getManagePopupMenu();
    GlobalKey<ScaffoldState> sacffoldkey = GlobalKey<ScaffoldState>();
    String menuTitle = Provider.of<MenuProvider>(
      context,
    ).menuTitle;
    final formKey = GlobalKey<FormState>();
    String commentContent = "";
    List<Comment> comments = Provider.of<BoardProvider>(
      context,
    ).boardList[index].comments;
    Board board = Provider.of<BoardProvider>(
      context,
    ).boardList[index];

    // Provider.of<ValidProvider>(context, listen: false).setValid(false);

    return Scaffold(
      key: sacffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 60.0,
        title: Text(
          menuTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            // fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          if (user.id == board.userId)
            PopupMenuButton<ManageMenu>(
              position: PopupMenuPosition.over,
              tooltip: "",
              // padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: const Padding(
                padding: EdgeInsets.only(right: 21.0),
                child: Icon(Icons.more_vert),
              ),
              onSelected: (ManageMenu item) {
                if (ManageMenu.update == item) {
                  getModifyBoardBottomSheet(context, width, height, index);
                } else if (ManageMenu.delete == item) {
                  Navigator.pop(context);
                  Provider.of<BoardProvider>(context, listen: false)
                      .removeBoard(board);
                }
              },
              itemBuilder: (context) {
                return list;
              },
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length + 2,
                itemBuilder: (context, idx) {
                  if (idx == 0) {
                    return Padding(
                      padding:
                          const EdgeInsets.fromLTRB(26.0, 16.0, 26.0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                            board.title,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: height * 0.016,
                                  fontWeight: FontWeight.bold,
                                ),
                                "${board.userId} | ${board.updateDate.substring(0, 4)}년 ${board.updateDate.substring(4, 6)}월 ${board.updateDate.substring(6, 8)}일 ${board.updateDate.substring(8, 10)}시 ${board.updateDate.substring(10, 12)}분 ${board.insertDate != board.updateDate ? '(수정됨)' : ''}",
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: height * 0.021,
                                fontWeight: FontWeight.bold,
                              ),
                              board.content,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (idx == 1) {
                    if (board.commentsCount > 0) {
                      return Divider(
                        thickness: 1.0,
                        color: Colors.grey.shade500,
                      );
                    } else {
                      return SizedBox();
                    }
                  } else {
                    return CommentCard(
                      height: height,
                      width: width,
                      commentIndex: idx - 2,
                      index: index,
                    );
                  }
                }),
          ),
          SizedBox(
            height: height * 0.05,
          ),
        ],
      ),
      bottomSheet: SizedBox(
        child: Form(
          key: formKey,
          child: TextFormField(
              style: TextStyle(
                fontSize: height * 0.021,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    final formKeyState = formKey.currentState!;
                    if (Provider.of<ValidProvider>(context, listen: false)
                        .isValid) {
                      formKeyState.save();
                      getLoadingDialog(context);
                      Provider.of<BoardProvider>(context, listen: false)
                          .addComment(
                              board.boardNo, user.id, commentContent, board)
                          .then((value) {
                        Provider.of<ValidProvider>(context, listen: false)
                            .setValid(false);
                        Navigator.pop(context);
                      });
                    }
                  },
                  icon: Consumer<ValidProvider>(
                    builder: (context, value, child) {
                      return Icon(
                        Icons.arrow_circle_up,
                        color: value.isValid
                            ? Colors.blue.shade500
                            : Colors.grey.shade500,
                      );
                    },
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              onSaved: (newValue) {
                commentContent = newValue!;
              },
              onChanged: (value) {
                Provider.of<ValidProvider>(context, listen: false)
                    .setValid(value.trim().isEmpty ? false : true);
              }),
        ),
      ),
    );
  }
}
