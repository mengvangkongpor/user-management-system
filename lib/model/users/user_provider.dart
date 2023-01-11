import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_management_system/model/users/delete.dart';
import 'package:user_management_system/model/users/updart.dart';
import 'display.dart';
import 'insert.dart';
import 'user_constructor.dart';

class UserProvider with ChangeNotifier {
  //Insert Data
  void addUser(User data) async {
    var db = InsertUserData(dbName: 'usermanagementsystem.db');
    await db.InsertUser(data);
    notifyListeners();
  }

  // ດຶງຂໍ້ມູນ
  List<User> usersList = [];
  void showUser() {
    Timer(Duration(milliseconds: 100), () async {
      var db = DisplayUser(dbName: "usermanagementsystem.db");
      usersList = await db.displayUser();
      notifyListeners();
    });
  }

  // ============= Update ===============
  // ຮັບຄ່າຈາກຟາຍ viewprofile.dart
  void solveUser(User data) async {
    var db = UpdateUser(dbName: 'usermanagementsystem.db');
    await db.updateUser(data);
    notifyListeners();
  }

  // delete
  void removeUser(String statement) async {
    var db = DeleteUser(dbName: 'usermanagementsystem.db');
    await db.deleteUser(statement);
    notifyListeners();
  }
}
