import 'package:flutter/material.dart';
import 'package:hus_quiz/models/board.dart';
import 'package:hus_quiz/models/comment.dart';
import 'package:hus_quiz/models/user.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/providers/valid_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_manage_popupmenu_list.dart';
import 'package:hus_quiz/utilities/functions/get_modify_comment_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.height,
    required this.width,
    required this.commentIndex,
    required this.index,
  }) : super(key: key);

  final double height;
  final double width;
  final int commentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    List<PopupMenuEntry<ManageMenu>> list = getManagePopupMenu();
    Board board =
        Provider.of<BoardProvider>(context, listen: false).boardList[index];
    Comment comment = Provider.of<BoardProvider>(context, listen: false)
        .boardList[index]
        .comments[commentIndex];

    return SizedBox(
      width: width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26.0, 4.0, 26.0, 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                    comment.content),
                Row(
                  mainAxisAlignment: user.id == comment.userId
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                      "${comment.userId} | ${comment.updateDate.substring(0, 4)}년 ${comment.updateDate.substring(4, 6)}월 ${comment.updateDate.substring(6, 8)}일 ${comment.updateDate.substring(8, 10)}시 ${comment.updateDate.substring(10, 12)}분 ${comment.insertDate != comment.updateDate ? '(수정됨)' : ''}",
                    ),
                    if (user.id == comment.userId)
                      PopupMenuButton<ManageMenu>(
                        position: PopupMenuPosition.over,
                        tooltip: "",
                        // padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.grey.shade700,
                        ),
                        onSelected: (ManageMenu item) {
                          if (ManageMenu.update == item) {
                            getModifyCommentBottomSheet(
                                context, width, height, index, commentIndex);
                          } else if (ManageMenu.delete == item) {
                            getLoadingDialog(context);
                            Provider.of<BoardProvider>(context, listen: false)
                                .removeComment(comment, board)
                                .then((value) {
                              Provider.of<ValidProvider>(context, listen: false)
                                  .setValid(false);
                              Navigator.pop(context);
                            });
                          }
                        },
                        itemBuilder: (context) {
                          return list;
                        },
                      ),
                    if (user.id != comment.userId)
                      const Icon(
                        Icons.more_horiz,
                        color: Colors.transparent,
                      ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}
