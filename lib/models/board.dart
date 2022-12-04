import 'package:hus_quiz/models/comment.dart';

class Board {
  int boardNo = 0;
  String userId;
  int boardCategory;
  String title;
  String content;
  late List<Comment> comments;
  late int commentsCount;
  late String insertDate;
  late String updateDate;

  Board(
    this.userId,
    this.boardCategory,
    this.title,
    this.content,
  );

  Board.fromJson(Map<String, dynamic> json)
      : boardNo = int.parse(json['board_no'].toString()),
        userId = json['user_id'].toString(),
        boardCategory = int.parse(json['board_category'].toString()),
        title = json['title'].toString(),
        content = json['content'].toString(),
        commentsCount = int.parse(json['comment_count'].toString()),
        insertDate = json['insert_date'].toString(),
        updateDate = json['update_date'].toString();

  Map<String, dynamic> toJson() => {
        'board_no': boardNo,
        'user_id': userId,
        'board_category': boardCategory,
        'title': title,
        'content': content,
      };
}
