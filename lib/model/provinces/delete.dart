import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';

class DeleteProvince extends UsersDB {
  DeleteProvince({required super.dbName});
  Future deleteProvince(String province_id_pk) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("provinces");
    Finder condition =
        Finder(filter: Filter.equals('province_id_pk', '${province_id_pk}'));
    var snapshotcheck = await store.find(db, finder: condition);
    await store.record(snapshotcheck[0].key).delete(db);
  }
}
