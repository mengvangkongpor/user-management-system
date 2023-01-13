import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/districts/district_constructor.dart';

class InsertDistrict extends UsersDB {
  InsertDistrict({required super.dbName});

  Future<int> insertDistrict(District data) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("districts");
    var keyID = store.add(db, {
      "province_id_fk": data.province_id_fk,
      "district_id_pk": data.district_id_pk,
      "district": data.district,
    });
    db.close();
    return keyID;
  }
}
