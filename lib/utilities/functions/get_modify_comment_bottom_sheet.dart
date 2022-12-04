import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/valid_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:provider/provider.dart';

void getModifyCommentBottomSheet(BuildContext context, double width,
    double height, int index, int commentIndex) {
  final formKey = GlobalKey<FormState>();
  String content = "";
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          // width: width * 0.7,
          height: height * 0.25,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final formKeyState = formKey.currentState!;
                            if (formKeyState.validate()) {
                              formKeyState.save();
                              getLoadingDialog(context);
                              Provider.of<BoardProvider>(context, listen: false)
                                  .boardList[index]
                                  .comments[commentIndex]
                                  .content = content;
                              Provider.of<BoardProvider>(context, listen: false)
                                  .modifyComment(
                                Provider.of<BoardProvider>(context,
                                        listen: false)
                                    .boardList[index]
                                    .comments[commentIndex],
                                Provider.of<BoardProvider>(context,
                                        listen: false)
                                    .boardList[index],
                              )
                                  .then((isSuccess) {
                                Provider.of<ValidProvider>(context,
                                        listen: false)
                                    .setValid(false);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text(
                            "수정",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontSize: height * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(height * 0.01),
                      child: TextFormField(
                        initialValue:
                            Provider.of<BoardProvider>(context, listen: false)
                                .boardList[index]
                                .comments[commentIndex]
                                .content,
                        keyboardType: TextInputType.multiline,
                        maxLines: 999,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          hintStyle: TextStyle(fontSize: 11),
                          alignLabelWithHint: true,
                          labelText: "Comment",
                          hintText: "댓글을 변경해 주세요",
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "댓글을 입력해 주세요";
                          }
                        },
                        onSaved: (newValue) => content = newValue!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
