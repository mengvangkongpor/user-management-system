import 'package:sembast/sembast.dart';
import 'package:user_management_system/local_database/user_db.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';

class DisplayProfiles extends UsersDB {
  DisplayProfiles({required super.dbName});

  Future<List<Profile>> displayProfile() async {
    var db = await openDB();
    var store = intMapStoreFactory.store('profiles');
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    final List<Profile> profileList = [];
    // int no_id = 1;
    for (var row in snapshot) {
      final profileModel = Profile(
          user_id_fk: row["user_id_fk"].toString(),
          profile_id_pk: row["profile_id_pk"].toString(),
          firstname: row['firstname'].toString(),
          lastname: row['lastname'].toString(),
          gender: row['gender'].toString(),
          dob: row['dob'].toString(),
          village: row['village'].toString(),
          district_id_fk: row['district_id_fk'].toString(),
          province_id_fk: row['province_id_fk'].toString(),
          imgprofile: row['imgprofile'].toString());
      profileList.add(profileModel);
    }
    return profileList;
  }
}
