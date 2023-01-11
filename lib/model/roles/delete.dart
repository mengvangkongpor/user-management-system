import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';

class DeleteRole extends UsersDB {
  DeleteRole({required super.dbName});
  Future deleteRole(String role_id) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("roles");
    Finder condition =
        Finder(filter: Filter.equals('role_id_pk', '${role_id}'));
    var snapshotcheck = await store.find(db, finder: condition);
    await store.record(snapshotcheck[0].key).delete(db);
  }
}
