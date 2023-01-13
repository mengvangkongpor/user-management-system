import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'user_constructor.dart';

class DisplayUser extends UsersDB {
  DisplayUser({required super.dbName});

  Future<List<User>> displayUser() async {
    var toDB = await openDB();
    var store = intMapStoreFactory.store("users");
    var snapshot = await store.find(toDB,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    final List<User> usersList = [];
    for (var value in snapshot) {
      final usersModel = User(
          user_id_pk: value["user_id_pk"].toString(),
          username: value["username"].toString(),
          email: value["email"].toString(),
          mobile: value["mobile"].toString(),
          password: value["password"].toString());
      usersList.add(usersModel);
    }
    return usersList;
  }
}
