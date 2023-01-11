import 'package:sembast/sembast.dart';
import 'user_constructor.dart';
import 'package:user_management_system/database/user_db.dart';

class InsertUserData extends UsersDB {
  InsertUserData({required super.dbName});

  Future<int> InsertUser(User statement) async {
    // database ==> store
    var db = await openDB();
    var store = intMapStoreFactory.store("users");

    //insert data into store in json format
    var keyID = store.add(db, {
      "user_id_pk": statement.user_id_pk,
      "username": statement.username,
      "email": statement.email,
      "mobile": statement.mobile,
      "password": statement.password
    });
    db.close();
    return keyID;
  }
}
