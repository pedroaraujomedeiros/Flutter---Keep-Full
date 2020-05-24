import 'dart:math';
import 'package:keep_full/Models/grocery_list.dart';

class Grocery{
  int id;
  String name;
  String quantity;
  String category;
  String measurementUnit;

  /// Constructors

  Grocery(this.id, this.name, this.quantity, this.measurementUnit, this.category);

  Grocery.newItem(){
    this.id = Random().nextInt(99999999);
    this.name = "";
    this.quantity = "";
    this.category = "";
    this.measurementUnit = "";
  }

  Grocery.fromJson(Map<String,dynamic> json){
    this.id = json[GroceryList.colId];
    this.name = json[GroceryList.colName];
    this.quantity = json[GroceryList.colQuantity];
    this.category = json[GroceryList.colCategory];
    this.measurementUnit = json[GroceryList.colMeasurementUnit];
  }


  ///Methods

  /// Grocery to Json
  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = Map<String,dynamic>();
    json[GroceryList.colId] = this.id;
    json[GroceryList.colName] = this.name;
    json[GroceryList.colQuantity] = this.quantity;
    json[GroceryList.colCategory] = this.category;
    json[GroceryList.colMeasurementUnit] = this.measurementUnit;
    return json;
  }

  @override
  bool operator == (other) {
    if(!(other is Grocery)){
      return false;
    }
    return this.id == (other as Grocery).id;
    //return (super as Grocery).id == (other as Grocery).id;
  }

  @override
  int get hashCode {
    return this.id;
    //(super as Grocery).id;
  }

  @override
  String toString() {
    return "id: ${this.id}\nname: ${this.name}\nquantity: ${this.quantity}\ncategory: ${this.category}\nMeasurement Unit: ${this.measurementUnit}\n";
  }

}