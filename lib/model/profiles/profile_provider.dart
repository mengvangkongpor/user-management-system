import 'package:flutter/cupertino.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';
import 'package:user_management_system/model/profiles/display.dart';
import 'package:user_management_system/model/profiles/insert.dart';
import 'package:user_management_system/model/profiles/update.dart';

class ProfileProvider with ChangeNotifier {
  // add profile
  void addProfile(Profile statement) {
    var db = InsertProfile(dbName: 'usermanagementsystem.db');
    Future.delayed(Duration(seconds: 1), () async {
      await db.insertProfile(statement);
    });
  }

  // show
  List<Profile> profileList = [];
  void showProfile() async {
    var db = DisplayProfiles(dbName: 'usermanagementsystem.db');
    Future.delayed(Duration(milliseconds: 100), () async {
      profileList = await db.displayProfile();
      notifyListeners();
    });
  }

  // ====== Update ========
  // update
  void solveProfile(Profile profile) async {
    var db = UpdateUserProfile(dbName: 'usermanagementsystem.db');
    await db.updateUserProfile(profile);
    notifyListeners();
  }
}
