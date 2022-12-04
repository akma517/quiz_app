import 'package:flutter/material.dart';
import 'package:hus_quiz/models/board.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/valid_provider.dart';
import 'package:hus_quiz/screens/board_screen.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:provider/provider.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    Key? key,
    required this.height,
    required this.width,
    required this.index,
  }) : super(key: key);

  final double height;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    Board board = Provider.of<BoardProvider>(context).boardList[index];
    return GestureDetector(
      onTap: () {
        getLoadingDialog(context);
        Provider.of<BoardProvider>(context, listen: false)
            .initBoardWithComment(board)
            .then(
          (value) {
            Provider.of<ValidProvider>(context, listen: false).setValid(false);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BoardScreen(index: index);
                },
              ),
            );
          },
        );
      },
      child: Card(
        shape: const BeveledRectangleBorder(
          side: BorderSide(color: Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                    board.commentsCount == 0
                        ? Icons.question_mark
                        : Icons.question_answer,
                    size: height * 0.05),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: height * 0.019,
                            fontWeight: FontWeight.bold,
                          ),
                          board.title.length < (width / 25).floor()
                              ? board.title
                              : board.title
                                  .substring(0, (width / 25).floor())
                                  .padRight((width / 25).floor() + 3, '.'),
                        ),
                        Text(
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: height * 0.0175,
                            fontWeight: FontWeight.bold,
                          ),
                          " ${board.commentsCount == 0 ? '' : '[${board.commentsCount}]'}",
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: height * 0.0145,
                        fontWeight: FontWeight.bold,
                      ),
                      "${board.userId} | ${board.updateDate.substring(0, 4)}년 ${board.updateDate.substring(4, 6)}월 ${board.updateDate.substring(6, 8)}일 ${board.updateDate.substring(8, 10)}시 ${board.updateDate.substring(10, 12)}분 ${board.insertDate != board.updateDate ? '(수정됨)' : ''}",
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
