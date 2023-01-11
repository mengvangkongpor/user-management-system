import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';

import 'role_constructor.dart';

class InsertRole extends UsersDB {
  InsertRole({required super.dbName});

  Future<int> insertRole(Role roles) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("roles");
    var keyID =
        store.add(db, {"role_id_pk": roles.role_id_pk, "role": roles.role});
    db.close();
    return keyID;
  }
}
