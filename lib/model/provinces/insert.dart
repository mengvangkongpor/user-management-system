import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';
import 'province_constructor.dart';

class InsertProvince extends UsersDB {
  InsertProvince({required super.dbName});

  Future insertProvince(Province statement) async {
    // open database
    var db = await openDB();
    // create store
    var store = intMapStoreFactory.store("provinces");

    // insert data into store in json format
    await store.add(db, {
      "province_id_pk": statement.province_id_pk,
      "province": statement.province
    });
  }
}
