import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class DeleteUserRole extends UsersDB {
  DeleteUserRole({required super.dbName});
  Future deleteUserRole(UserRole statement) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("users_has_roles");
    Finder condition =
        Finder(filter: Filter.equals('user_id_fk', statement.user_id_fk));
    var snapshotcheck = await store.find(db, finder: condition);

    if (snapshotcheck.length == 1) {
      if (snapshotcheck[0]['role_id_fk'] == statement.role_id_fk) {
        await store.record(snapshotcheck[0].key).delete(db);
      }
    }

    if (snapshotcheck.length == 2) {
      if (snapshotcheck[0]['role_id_fk'] == statement.role_id_fk) {
        await store.record(snapshotcheck[0].key).delete(db);
      } else if (snapshotcheck[1]['role_id_fk'] == statement.role_id_fk) {
        await store.record(snapshotcheck[1].key).delete(db);
      }
    }

    if (snapshotcheck.length == 3) {
      if (snapshotcheck[0]['role_id_fk'] == statement.role_id_fk) {
        await store.record(snapshotcheck[0].key).delete(db);
      } else if (snapshotcheck[1]['role_id_fk'] == statement.role_id_fk) {
        await store.record(snapshotcheck[1].key).delete(db);
      } else if (snapshotcheck[2]['role_id_fk'] == statement.role_id_fk) {
        await store.record(snapshotcheck[2].key).delete(db);
      }
    }
  }
}
