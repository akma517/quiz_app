class Comment {
  int commentNo = 0;
  int boardNo;
  String userId;
  String content;
  late String insertDate;
  late String updateDate;

  Comment(
    this.boardNo,
    this.userId,
    this.content,
  );

  Comment.fromJson(Map<String, dynamic> json)
      : commentNo = int.parse(json['comment_no'].toString()),
        boardNo = int.parse(json['board_no'].toString()),
        userId = json['user_id'].toString(),
        content = json['content'].toString(),
        insertDate = json['insert_date'].toString(),
        updateDate = json['update_date'].toString();

  Map<String, dynamic> toJson() => {
        'comment_no': commentNo,
        'user_id': userId,
        'board_no': boardNo,
        'content': content,
      };
}
