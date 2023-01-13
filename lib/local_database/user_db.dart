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
}
