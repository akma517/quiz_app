import 'package:flutter/material.dart';
import 'package:hus_quiz/providers/user_provider.dart';
import 'package:hus_quiz/screens/init_screen.dart';
import 'package:hus_quiz/utilities/functions/get_change_password_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_guest_login_dialog.dart';
import 'package:hus_quiz/utilities/functions/get_user_popupmenu_list.dart';
import 'package:provider/provider.dart';

AppBar getAppBar(String menuTitle, String userName, BuildContext context,
    double width, double height, List<PopupMenuEntry<UserMenu>> list) {
  return AppBar(
    toolbarHeight: 60.0,
    title: Text(
      menuTitle,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        // fontSize: 30,
      ),
    ),
    centerTitle: true,
    actions: <Widget>[
      PopupMenuButton<UserMenu>(
        position: PopupMenuPosition.under,
        tooltip: "",
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
              size: 30.0,
            ),
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        onSelected: (UserMenu item) {
          if (UserMenu.logout == item) {
            Provider.of<UserProvider>(context, listen: false).logout().then(
                  (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const InitScreen();
                      },
                    ),
                    (route) => false,
                  ),
                );
          } else if (UserMenu.login == item) {
            getGuestLoginDialog(context, width, height);
          } else if (UserMenu.changePassword == item) {
            getChangePasswordDialog(context, width, height);
          }
        },
        itemBuilder: (context) {
          return list;
        },
      ),
    ],
  );
}
