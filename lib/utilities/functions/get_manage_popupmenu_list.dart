import 'package:flutter/material.dart';

enum ManageMenu { update, delete }

List<PopupMenuEntry<ManageMenu>> getManagePopupMenu() {
  var list = <PopupMenuEntry<ManageMenu>>[
    const PopupMenuItem<ManageMenu>(
      value: ManageMenu.update,
      child: Center(
        child: Text(
          '수정하기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    const PopupMenuDivider(height: 10.0),
    const PopupMenuItem<ManageMenu>(
      value: ManageMenu.delete,
      child: Center(
        child: Text(
          '삭제하기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ];
  return list;
}
