import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final tableName = 'journeys';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "journeys_database.db");
    var database = await openDatabase(path, version: 1, onCreate: initDB);
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY, "
        "routeId INTEGER, "
        "routeName TEXT, "
        "stopId INTEGER, "
        "stopName TEXT, "
        "direction INTEGER, "
        "journeyName TEXT "
        ")");
  }
}
