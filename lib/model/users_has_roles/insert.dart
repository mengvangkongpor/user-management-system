import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class InsertUserRole extends UsersDB {
  InsertUserRole({required super.dbName});

  Future insertUserRole(UserRole statement) async {
    // database ==> store
    var db = await openDB();
    var store = intMapStoreFactory.store("users_has_roles");

    //insert data into store in json format
    store.add(db, {
      "user_id_fk": statement.user_id_fk,
      "role_id_fk": statement.role_id_fk
    });
    print(statement.user_id_fk);
    print(statement.role_id_fk);
    db.close();
  }
}
