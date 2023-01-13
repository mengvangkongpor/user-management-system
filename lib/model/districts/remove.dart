import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';

import 'district_constructor.dart';

class DisplayDistrict extends UsersDB {
  DisplayDistrict({required super.dbName});

  Future<List<District>> displayDistrict() async {
    var db = await openDB();
    var store = intMapStoreFactory.store("districts");
    var snapshot = await store.find(
      db,
      finder: Finder(sortOrders: [SortOrder(Field.key, false)]),
    );
    final List<District> districtList = [];
    var no = 1;
    for (var row in snapshot) {
      final districtModel = District(
          province_id_fk: row["province_id_fk"].toString(),
          district_id_pk: (no++).toString(),
          district: row["district"].toString());
      districtList.add(districtModel);
    }
    return districtList;
  }
}
