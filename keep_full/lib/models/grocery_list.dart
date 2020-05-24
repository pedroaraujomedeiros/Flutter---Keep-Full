import 'models.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';

class GroceryList{

  List<Grocery> items = List<Grocery>();

  /// Constructors
  GroceryList(){
    items = List<Grocery>();
  }

  GroceryList.fromJson(Map<String, Object> json){
    this.items = List<Grocery>();
  }

  /// Methods

  /// Add an item
  Future<void> addItem(Grocery item) async{
    this.items.add(item);
    await dbInsert(item);
    return ;
  }

  /// Update an item
  Future<void> editItem(Grocery item) async{
    this.items[this.items.indexOf(item)] = item;
    await dbUpdate(item);
    return ;
  }

  /// Delete an item
  Future<void> deleteItem(Grocery item) async{
    this.items.remove(item);
    await dbDelete(item);
    return ;
  }


  /// Database Properties

  static final table = "tb_grocery_list";
  static final colId = "id";
  static final colName = "name";
  static final colQuantity = "quantity";
  static final colCategory = "category";
  static final colMeasurementUnit = "measurementUnit";
  static final colUserId = "measurementUnit";
  static final colDtCreation = "dtCreation";

  /// Create the tb_grocery_list table on sqlite database
  static Future<void> dbCreateTable(Database db) async{

      return await db.execute(
          '''
          CREATE TABLE $table (
            $colId INTEGER PRIMARY KEY,
            $colName TEXT NOT NULL,
            $colQuantity TEXT NOT NULL,
            $colCategory TEXT NOT NULL,
            $colMeasurementUnit TEXT NOT NULL,
            $colDtCreation DATETIME DEFAULT current_timestamp
            )
          ''');
  }

  /// Insert Row into database
  static Future<int> dbInsert(Grocery item) async{
    Database db = await DataBaseHelper.instance.database;
    Map<String,dynamic> values = item.toJson();
    int rowsInsert = await db.insert(table, values);
    return rowsInsert;
  }

  /// Update Row in database
  static Future<int> dbUpdate(Grocery item) async{
    Database db = await DataBaseHelper.instance.database;
    Map<String,dynamic> values = item.toJson();
    print(values);
    return await db.update(table, values, where: "$colId = ? ", whereArgs:[item.id]);

  }

  /// Retrieve Row from table
  static Future<int> dbDelete(Grocery item) async{
    Database db = await DataBaseHelper.instance.database;
    return await db.delete(table, where: "$colId = ?", whereArgs: [item.id]);
  }

  /// Query All Rows from table
  static Future<List<Grocery>> dbQueryAllRows() async{
    Database db = await DataBaseHelper.instance.database;

    /// Query all rows from table
    final List<Map<String,dynamic>> rows = await db.query(table, orderBy: "dtCreation");
    final List<Grocery> groceries = List<Grocery>();

    rows.forEach((element) {
      groceries.add(Grocery.fromJson(element));
    });

    return groceries;
  }

  /// Delete All Rows
  /// This function is called in logout process
  static Future<int>  dbTruncate() async{
    Database db = await DataBaseHelper.instance.database;
    return await db.delete(table);

  }
}