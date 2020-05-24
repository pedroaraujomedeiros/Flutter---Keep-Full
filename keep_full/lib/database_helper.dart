import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import './Models/models.dart';

/// Database Helper
class DataBaseHelper {
  static final _databaseName = 'KeepFullDB.db';
  static final _databaseVersion = 1;

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(path,
        version: _databaseVersion,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await GroceryList.dbCreateTable(db);
    });
    return db;
  }

  static Database _database;
  Future<Database> get database async {
    if (_database == null) {
      return await _initDatabase();
    }
    return _database;
  }


  Future<void> truncateDatabase() async{
    await GroceryList.dbTruncate();
  }
}
