import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class UsersDB {
  String dbName;

  UsersDB({required this.dbName});

  Future<Database> openDB() async {
    // ຫາຕຳແໜ່ງທີ່ຈະເກັບຖານຂໍ້ມູນ
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    // create database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }
  // // insert data
  // Future<int> InsertUser(Users statement) async {
  //   // database ==> store
  //   var db = await this.openDB();
  //   var store = intMapStoreFactory.store("users");

  //   // json data
  //   var keyID = store.add(db, {
  //     "id": statement.id,
  //     "username": statement.username,
  //     "email": statement.email,
  //     "mobile": statement.mobile,
  //     "password": statement.password
  //   });
  //   db.close();
  //   return keyID;
  // }

  // load data
  // Future<List<User>> loadAlldata() async {
  //   var db = await this.openDB();
  //   var store = intMapStoreFactory.store("users");
  //   var snapshot = await store.find(db,
  //       finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
  //   List<User> usersList = [];
  //   for (var record in snapshot) {
  //     final usersModel = User(
  //         id: record["id"].toString(),
  //         username: record["username"].toString(),
  //         email: record["email"].toString(),
  //         mobile: record["mobile"].toString(),
  //         password: record["password"].toString());
  //     usersList.add(usersModel);
  //   }
  //   return usersList;
  // }
}
