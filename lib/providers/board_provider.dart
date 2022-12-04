import 'package:flutter/material.dart';
import 'package:hus_quiz/models/board.dart';
import 'package:hus_quiz/models/comment.dart';
import 'package:hus_quiz/services/board_service.dart';
import 'package:hus_quiz/services/comment_service.dart';

enum BoardCategory {
  questionComplain,
  systemComplain,
}

class BoardProvider extends ChangeNotifier {
  late BoardCategory boardCategory;
  late String menuTitle;
  late List<Board> boardList;

  BoardService boardService = BoardService();
  CommentService commentService = CommentService();

  Map<BoardCategory, int> boardCategoryMap = {
    BoardCategory.questionComplain: 1,
    BoardCategory.systemComplain: 2,
  };

  Future<bool> initBoardList() async {
    boardList =
        await boardService.getBoardList(boardCategoryMap[boardCategory]!);

    return true;
  }

  Future<bool> initBoardWithComment(Board board) async {
    board.comments = await commentService.getComments(board.boardNo);
    return true;
  }

  Future<bool> addBoard(String userId, String title, String content) async {
    Board board =
        Board(userId, boardCategoryMap[boardCategory]!, title, content);

    bool success = await boardService.addBoard(board);

    boardList =
        await boardService.getBoardList(boardCategoryMap[boardCategory]!);
    notifyListeners();

    return success;
  }

  Future<bool> modifyBoard(Board board) async {
    bool success = await boardService.modifyBoard(board);
    int tmpBoardNo = board.boardNo;
    boardList =
        await boardService.getBoardList(boardCategoryMap[boardCategory]!);
    Board tmpBoard =
        boardList.where((element) => element.boardNo == tmpBoardNo).toList()[0];

    tmpBoard.comments = await commentService.getComments(tmpBoardNo);
    notifyListeners();
    return success;
  }

  Future<bool> removeBoard(Board board) async {
    bool success = false;

    if (board.commentsCount > 0) {
      success = await commentService.removeAllComment(board.boardNo) &&
          await boardService.removeBoard(board);
    } else {
      success = await boardService.removeBoard(board);
    }

    boardList =
        await boardService.getBoardList(boardCategoryMap[boardCategory]!);

    notifyListeners();

    return success;
  }

  Future<bool> addComment(
      int boardNo, String userId, String content, Board board) async {
    Comment comment = Comment(boardNo, userId, content);
    bool success = await commentService.addComment(comment);
    board.comments = await commentService.getComments(board.boardNo);
    board.commentsCount = board.comments.length;
    notifyListeners();
    return success;
  }

  Future<bool> modifyComment(Comment comment, Board board) async {
    bool success = await commentService.modifyComment(comment);

    int tmpBoardNo = board.boardNo;
    boardList =
        await boardService.getBoardList(boardCategoryMap[boardCategory]!);
    Board tmpBoard =
        boardList.where((element) => element.boardNo == tmpBoardNo).toList()[0];

    tmpBoard.comments = await commentService.getComments(tmpBoardNo);

    notifyListeners();
    return success;
  }

  Future<bool> removeComment(Comment comment, Board board) async {
    bool success = await commentService.removeComment(comment);
    board.comments = await commentService.getComments(board.boardNo);
    board.commentsCount = board.comments.length;
    notifyListeners();
    return success;
  }
}
