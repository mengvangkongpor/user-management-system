import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class DisplayUserRole extends UsersDB {
  DisplayUserRole({required super.dbName});

  Future<List<UserRole>> displayUserRole() async {
    var toDB = await openDB();
    var store = intMapStoreFactory.store("users_has_roles");
    var snapshot = await store.find(toDB,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    final List<UserRole> users_roleList = [];
    for (var res in snapshot) {
      final users_roleModel = UserRole(
          user_id_fk: res['user_id_fk'].toString(),
          role_id_fk: res['role_id_fk'].toString());
      users_roleList.add(users_roleModel);
    }
    return users_roleList;
  }
}
