import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';

class DeleteDistrict extends UsersDB {
  DeleteDistrict({required super.dbName});
  Future deleteDistrict(String district_id_pk) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("districts");
    Finder condition =
        Finder(filter: Filter.equals('district_id_pk', '$district_id_pk'));
    var snapshotcheck = await store.find(db, finder: condition);
    await store.record(snapshotcheck[0].key).delete(db);
  }
}
