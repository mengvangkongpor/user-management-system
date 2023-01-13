import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';

class DeleteUser extends UsersDB {
  DeleteUser({required super.dbName});
  Future deleteUser(String user_id_pk) async {
    var db = await openDB();
    // delete users
    var users_store = intMapStoreFactory.store("users");
    Finder condition =
        Finder(filter: Filter.equals('user_id_pk', '${user_id_pk}'));
    var snapshotUsers = await users_store.find(db, finder: condition);
    await users_store.record(snapshotUsers[0].key).delete(db);
    print("User=${snapshotUsers}");
    print("User=${snapshotUsers.length}");
    // delete profiles
    var profiles_store = intMapStoreFactory.store("profiles");
    Finder condition2 =
        Finder(filter: Filter.equals('user_id_fk', '${user_id_pk}'));
    var snapshotProfiles = await profiles_store.find(db, finder: condition2);
    if (snapshotProfiles.length != 0) {
      await profiles_store.record(snapshotProfiles[0].key).delete(db);
    }

    // delete users_has_roles
    var users_has_roles_store = intMapStoreFactory.store("users_has_roles");
    Finder condition3 =
        Finder(filter: Filter.equals('user_id_fk', '${user_id_pk}'));
    var snapshotUsersRoles =
        await users_has_roles_store.find(db, finder: condition3);
    if (snapshotUsersRoles.length != 0) {
      await users_has_roles_store.record(snapshotUsersRoles[0].key).delete(db);
    }
  }
}
