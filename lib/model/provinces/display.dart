import 'package:sembast/sembast.dart';
import 'package:user_management_system/database/user_db.dart';
import 'province_constructor.dart';

class DisplayProvince extends UsersDB {
  DisplayProvince({required super.dbName});

  Future<List<Province>> displayProvince() async {
    var db = await openDB();
    var store = intMapStoreFactory.store("provinces");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    final List<Province> provinceList = [];
    for (var row in snapshot) {
      final provinceModel = Province(
        province_id_pk: row["province_id_pk"].toString(),
        province: row["province"].toString(),
      );
      provinceList.add(provinceModel);
    }
    return provinceList;
  }
}
