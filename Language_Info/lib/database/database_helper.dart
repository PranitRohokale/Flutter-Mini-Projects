import 'dart:io';

import 'package:lang_info/model/level.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  //variables
  static final _dbName = "puzzle.db";
  static final _dbVersion = 1;

  String tableName = 'levaltable';
  String colId = 'id';
  String colLeval = 'leval';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null)
      _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _dbName;
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colLeval INTEGER DEFAULT 0
      )
    ''');
  }

  //functions
  Future<List<Map<String, dynamic>>> getLevelMapList() async {
    Database db = await this.database;

    var result = await db.query(tableName);
    return result;
  }

  Future<List<Leval>> getLevalList() async {
    var levalMapList = await getLevelMapList();

    List<Leval> levalList = List<Leval>();

    levalMapList.forEach((element) {
      levalList.add(Leval.fromMapObject(element));
    });
    return levalList;
  }

  Future<int> getLeval() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT $colLeval from $tableName limit 1');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

  Future<int> updateLeval(Leval row) async {
		var db = await this.database;
		var result = await db.update(tableName, row.toMap(), where: '$colId = ?', whereArgs: [row.id]);
		return result;
	}
}
