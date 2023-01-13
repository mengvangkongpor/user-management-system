import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';

import 'role_constructor.dart';

class DisplayRole extends UsersDB {
  DisplayRole({required super.dbName});
  Future<List<Role>> displayRole() async {
    var db = await openDB();
    var store = intMapStoreFactory.store("roles");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    final List<Role> roleList = [];
    for (var res in snapshot) {
      final roleModel = Role(
          role_id_pk: res["role_id_pk"].toString(),
          role: res["role"].toString());
      roleList.add(roleModel);
    }

    return roleList;
  }
}
