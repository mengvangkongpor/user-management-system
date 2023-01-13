import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/users/user_constructor.dart';

class UpdateUser extends UsersDB {
  UpdateUser({required super.dbName});
  Future updateUser(User statement) async {
    var mydb = await openDB();
    var store_users = intMapStoreFactory.store('users');
    var getKeyID = await store_users.find(mydb,
        finder:
            Finder(filter: Filter.equals("user_id_pk", statement.user_id_pk)));

    // Update Username
    if (statement.username != "") {
      await store_users
          .record(getKeyID[0].key)
          .update(mydb, {"username": statement.username});
    }
    // Update Email
    if (statement.email != "") {
      await store_users
          .record(getKeyID[0].key)
          .update(mydb, {"email": statement.email});
    }
    //Update Mobile Phone
    if (statement.mobile != "") {
      await store_users
          .record(getKeyID[0].key)
          .update(mydb, {"mobile": statement.mobile});
    }
    //Update Password
    if (statement.password != "") {
      await store_users
          .record(getKeyID[0].key)
          .update(mydb, {"password": statement.password});
    }
  }
}
