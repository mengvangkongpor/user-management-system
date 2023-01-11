import 'package:flutter/material.dart';
import 'package:user_management_system/model/districts/delete.dart';
import 'package:user_management_system/model/districts/display.dart';
import 'package:user_management_system/model/districts/district_constructor.dart';
import 'package:user_management_system/model/districts/insert.dart';
import 'package:user_management_system/model/districts/update.dart';

class DistrictProvider with ChangeNotifier {
  // insert district
  void addDistrict(District statement) async {
    var db = await InsertDistrict(dbName: 'usermanagementsystem.db');
    await db.insertDistrict(statement);
    notifyListeners();
  }

  List<District> districtList = [];
  // display district
  void showDistrict() {
    Future.delayed(Duration(milliseconds: 100), () async {
      var db = await DisplayDistrict(dbName: 'usermanagementsystem.db');
      districtList = await db.displayDistrict();
      notifyListeners();
    });
  }

  // update
  void solveDistrict(District statement) async {
    var db = UpdateDistrict(dbName: 'usermanagementsystem.db');
    await db.updateDistrict(statement);
    notifyListeners();
  }

  // delete
  void removeDistrict(String statement) async {
    var db = DeleteDistrict(dbName: 'usermanagementsystem.db');
    await db.deleteDistrict(statement);
    notifyListeners();
  }
}
