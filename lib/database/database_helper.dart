import 'dart:io';

import 'package:notekeeper/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //private constructor to make singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //variables
  static final _dbName = "taskDatabase.db";
  static final _dbVersion = 1;

  String _tableName = "task_table";
  String coloumId = "_id";
  String coloumTitle = "title";
  String coloumDescription = "description";
  String coloumDate = "date";
  String coloumPriority = "priority";
  String coloumStatus = "status";

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tableName (
          $coloumId INTEGER PRIMARY KEY,
          $coloumTitle TEXT NOT NULL,
          $coloumDescription TEXT,
          $coloumDate TEXT,
          $coloumPriority TEXT NOT NULL,
          $coloumStatus INTEGER
        )
      ''');
  }

  //insert function
  Future<int> insertTask(Task row) async {
    Database db = await instance.database;

    return await db.insert(_tableName, row.toMap());
  }

  //updatetask
  Future<int> updateTask(Task row) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      row.toMap(),
      where: '$coloumPriority:?',
      whereArgs: [row.id],
    );
  }

  //selectAll
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await instance.database;

    return await db.query(_tableName);
  }

  //converting the object class
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((element) {
      taskList.add(Task.fromMap(element));
    });
    return taskList;
  }

  //delete
  Future<int> deleteTask(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: "$coloumId= ?", whereArgs: [id]);
  }

  //count rows
  Future<int> totalRows() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery("Select count(*) from $_tableName");

    return Sqflite.firstIntValue(x);
  }
}
  