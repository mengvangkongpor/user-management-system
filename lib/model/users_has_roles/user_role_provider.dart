import 'package:flutter/cupertino.dart';
import 'package:user_management_system/model/users_has_roles/delete.dart';
import 'package:user_management_system/model/users_has_roles/display.dart';
import 'package:user_management_system/model/users_has_roles/insert.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class UserRoleProvider with ChangeNotifier {
  // insert
  void addUserRole(UserRole data) async {
    var db = InsertUserRole(dbName: 'usermanagementsystem.db');
    await db.insertUserRole(data);
    notifyListeners();
  }

  // show
  List<UserRole> user_roleList = [];
  void showUserRole() {
    Future.delayed(Duration(milliseconds: 100), () async {
      var db = await DisplayUserRole(dbName: 'usermanagementsystem.db');
      user_roleList = await db.displayUserRole();
      notifyListeners();
    });
  }

  // delete
  void removeUserRole(UserRole statement) async {
    var db = DeleteUserRole(dbName: 'usermanagementsystem.db');
    await db.deleteUserRole(statement);
    notifyListeners();
  }
}
