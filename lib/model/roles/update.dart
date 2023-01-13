import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';

class UpdateRole extends UsersDB {
  UpdateRole({required super.dbName});
  Future updateRole(Role statement) async {
    var db = await openDB();
    var store = intMapStoreFactory.store('roles');
    var getKeyID = await store.find(db,
        finder:
            Finder(filter: Filter.equals('role_id_pk', statement.role_id_pk)));

    await store.record(getKeyID[0].key).update(db, {"role": statement.role});
  }
}
