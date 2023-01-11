import 'package:flutter/material.dart';
import 'package:user_management_system/model/provinces/delete.dart';
import 'package:user_management_system/model/provinces/display.dart';
import 'package:user_management_system/model/provinces/update.dart';
import 'insert.dart';
import 'province_constructor.dart';

class ProvinceProvider with ChangeNotifier {
  // add
  void addProvince(Province data) async {
    var db = InsertProvince(dbName: 'usermanagementsystem.db');
    await db.insertProvince(data);
    notifyListeners();
  }

  // display
  List<Province> provinceList = [];
  void showProvince() {
    Future.delayed(Duration(milliseconds: 100), () async {
      var db = DisplayProvince(dbName: 'usermanagementsystem.db');
      provinceList = await db.displayProvince();
      notifyListeners();
    });
  }

  // update
  void solveProvince(Province statement) async {
    var db = UpdateProvince(dbName: 'usermanagementsystem.db');
    await db.updateProvince(statement);
    notifyListeners();
  }

  // delete
  void removeProvince(String statement) async {
    var db = DeleteProvince(dbName: 'usermanagementsystem.db');
    await db.deleteProvince(statement);
    notifyListeners();
  }
}
