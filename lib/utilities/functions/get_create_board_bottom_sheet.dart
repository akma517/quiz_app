import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/board_provider.dart';
import 'package:hus_quiz/providers/menu_provider.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/utilities/functions/get_loading_dialog.dart';
import 'package:provider/provider.dart';

void getCreateBoardBottomSheet(
    BuildContext context, double width, double height) {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String content = "";
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        // width: width * 0.7,
        // height: height * 0.7,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                      Text(
                        Provider.of<MenuProvider>(context, listen: false)
                            .menuTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.025,
                          // fontSize: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final formKeyState = formKey.currentState!;
                          if (formKeyState.validate()) {
                            formKeyState.save();
                            getLoadingDialog(context);
                            Provider.of<BoardProvider>(context, listen: false)
                                .addBoard(
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .user
                                        .id,
                                    title,
                                    content)
                                .then((isSuccess) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Text(
                          "??????",
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
                Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      hintStyle: TextStyle(fontSize: 11),
                      labelText: "Title",
                      hintText: "????????? ????????? ?????????",
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) return "????????? ????????? ?????????";
                    },
                    onSaved: (newValue) => title = newValue!,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.01),
                    child: TextFormField(
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
                        labelText: "Content",
                        hintText: "????????? ????????? ?????????",
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "????????? ????????? ?????????";
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
      );
    },
  );
}
