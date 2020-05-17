

class Grocery{
  int id;
  String name;
  String quantity;
  String category;
  String measurementUnit;
  Grocery(this.id, this.name, this.quantity, this.measurementUnit, this.category);

  Grocery.newItem(){
    this.id = -1;
    this.name = "";
    this.quantity = "";
    this.category = "";
    this.measurementUnit = "";
  }
}