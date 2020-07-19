import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final chapterTable = 'chapterTable';
final mangaTable = 'mangaTable';

class DBProvider {
  static final DBProvider instance = DBProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'MangaMint.db');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB
    );
    return database;
  }

  void initDB(Database database, int version) async {
    await database
        .execute('''CREATE TABLE $chapterTable ("id INTEGER PRIMARY KEY AUTOINCREMENT,
        endpoint TEXT, index INTEGER")''');
    await database
    .execute('''CREATE TABLE $chapterTable ("id INTEGER PRIMARY KEY AUTOINCREMENT,
        endpoint TEXT, index INTEGER")''');
  }
}
