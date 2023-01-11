import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';
import 'package:user_management_system/model/provinces/province_constructor.dart';

class UpdateProvince extends UsersDB {
  UpdateProvince({required super.dbName});
  Future updateProvince(Province statement) async {
    var db = await openDB();
    var store = intMapStoreFactory.store('provinces');
    var getKeyID = await store.find(db,
        finder: Finder(
            filter: Filter.equals('province_id_pk', statement.province_id_pk)));
    await store
        .record(getKeyID[0].key)
        .update(db, {"province": statement.province});
  }
}
