import 'package:flutter/foundation.dart';
import 'package:user_management_system/model/roles/delete.dart';
import 'package:user_management_system/model/roles/display.dart';
import 'package:user_management_system/model/roles/update.dart';
import 'role_constructor.dart';
import 'insert.dart';

class RoleProvider with ChangeNotifier {
  // insert
  void addRole(Role data) async {
    var db = InsertRole(dbName: 'usermanagementsystem.db');
    await db.insertRole(data);
    notifyListeners();
  }

  // show
  List<Role> roleList = [];
  void showRole() {
    Future.delayed(Duration(milliseconds: 100), () async {
      var db = DisplayRole(dbName: 'usermanagementsystem.db');

      roleList = await db.displayRole();
      notifyListeners();
    });
  }

  // update
  void solveRole(Role statement) async {
    var db = UpdateRole(dbName: 'usermanagementsystem.db');
    await db.updateRole(statement);
    notifyListeners();
  }

  // delete
  void removeRole(String statement) async {
    var db = DeleteRole(dbName: 'usermanagementsystem.db');
    await db.deleteRole(statement);
    notifyListeners();
  }
}
