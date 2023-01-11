import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';
import 'package:user_management_system/model/districts/district_constructor.dart';

class UpdateDistrict extends UsersDB {
  UpdateDistrict({required super.dbName});
  Future updateDistrict(District statement) async {
    var db = await openDB();
    var store = intMapStoreFactory.store('districts');
    var getKeyID = await store.find(db,
        finder: Finder(
            filter: Filter.equals('district_id_pk', statement.district_id_pk)));
    await store.record(getKeyID[0].key).update(db, {
      "province_id_fk": statement.province_id_fk,
      "district": statement.district,
    });
  }
}
