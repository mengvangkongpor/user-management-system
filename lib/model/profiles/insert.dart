import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';

class InsertProfile extends UsersDB {
  InsertProfile({required super.dbName});

  Future<int> insertProfile(Profile statement) async {
    var db = await openDB();
    var store = intMapStoreFactory.store("profiles");
    var keyID = store.add(db, {
      "user_id_fk": statement.user_id_fk,
      "profile_id_pk": statement.profile_id_pk,
      "firstname": statement.firstname,
      "lastname": statement.lastname,
      "gender": statement.gender,
      "dob": statement.dob,
      "village": statement.village,
      "district_id_fk": statement.district_id_fk,
      "province_id_fk": statement.province_id_fk,
      "imgprofile": statement.imgprofile,
    });
    db.close();
    return keyID;
  }
}
