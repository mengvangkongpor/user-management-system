import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';

class UpdateUserProfile extends UsersDB {
  UpdateUserProfile({required super.dbName});
  Future updateUserProfile(Profile profile) async {
    var db = await openDB();
    var store = intMapStoreFactory.store('profiles');

    var getKeyID = await store.find(db,
        finder: Finder(
            filter:
                Filter.equals('profile_id_pk', '${profile.profile_id_pk}')));

    // Update Firstname and Lastname
    if (profile.firstname != "" && profile.lastname != "") {
      await store.record(getKeyID[0].key).update(db, {
        "firstname": "${profile.firstname}",
        "lastname": "${profile.lastname}",
      });
    }

    // Update Gender
    if (profile.gender != "") {
      await store
          .record(getKeyID[0].key)
          .update(db, {"gender": "${profile.gender}"});
    }

    // Update Dob
    if (profile.dob != "") {
      await store.record(getKeyID[0].key).update(db, {"dob": "${profile.dob}"});
    }

    if (profile.village != "" &&
        profile.district_id_fk != "" &&
        profile.province_id_fk != "") {
      await store.record(getKeyID[0].key).update(db, {
        "village": "${profile.village}",
        "district_id_fk": "${profile.district_id_fk}",
        "province_id_fk": "${profile.province_id_fk}"
      });
    }
  }
}
