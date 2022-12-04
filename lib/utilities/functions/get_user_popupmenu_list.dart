import 'package:flutter/material.dart';
import 'package:hus_quiz/models/user.dart';

enum UserMenu { changePassword, login, logout, signIn, signOut }

List<PopupMenuEntry<UserMenu>> getUserPopupMenu(User user) {
  var list = user.auth > 0
      ? <PopupMenuEntry<UserMenu>>[
          const PopupMenuItem<UserMenu>(
            value: UserMenu.changePassword,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                '비밀번호변경',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const PopupMenuDivider(height: 10.0),
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.signIn,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '회원가입',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // const PopupMenuDivider(height: 10.0),
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.signOut,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '회원탈퇴',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // const PopupMenuDivider(height: 10.0),
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.login,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '로그인',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //       textAlign: TextAlign.left,
          //     ),
          //   ),
          // ),
          // const PopupMenuDivider(height: 10.0),
          const PopupMenuItem<UserMenu>(
            value: UserMenu.logout,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                '로그아웃',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]
      : <PopupMenuEntry<UserMenu>>[
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.changePassword,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '비밀번호변경',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // const PopupMenuDivider(height: 10.0),
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.signIn,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '회원가입',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // const PopupMenuDivider(height: 10.0),
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.signOut,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '회원탈퇴',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // const PopupMenuDivider(height: 10.0),
          const PopupMenuItem<UserMenu>(
            value: UserMenu.login,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                '로그인',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // const PopupMenuDivider(height: 10.0),
          // const PopupMenuItem<UserMenu>(
          //   value: UserMenu.logout,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Text(
          //       '로그아웃',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
        ];
  return list;
}
