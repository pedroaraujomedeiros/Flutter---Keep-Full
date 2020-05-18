
import 'package:flutter/material.dart';
import '../Models/Grocery.dart';


class MeasurementUnits{

  static List<String> get units{
    List<String> measurementUnits = [];
    measurementUnits.add("Kg");
    measurementUnits.add("g");
    measurementUnits.add("l");
    measurementUnits.add("oz");
    measurementUnits.add("unt");
    return measurementUnits;
  }

}

class Categories{

  static List<String> get categories{
    List<String> categories = [];
    categories.add("Food");
    categories.add("Bakery");
    categories.add("Dairy");
    return categories;
  }

}




class GroceryItem extends StatefulWidget {
  //final String actionLabel;
  final Grocery grocery;
  final Function addNewGroceryItem;
  final Function editGroceryItem;

  GroceryItem(this.grocery, this.addNewGroceryItem, this.editGroceryItem);

  /// property isNewGrocery
  bool get isNewGrocery{
    return grocery.id<=0;
  }

  @override
  _GroceryItemState createState() => _GroceryItemState();
}

class _GroceryItemState extends State<GroceryItem> {
  final _itemNameController = TextEditingController();
  final _quantityController = TextEditingController();
  String measurementUnitValue = "Kg";
  String categoryValue = "Food";

  FocusNode quantityFocusNode;
  FocusNode categoryFocusNode;


  void _submitData() {
    final itemName = _itemNameController.text;
    final quantity = _quantityController.text;

    /// If any value is empty, cancel submission
    if (itemName.isEmpty || quantity.isEmpty || categoryValue.isEmpty) {
      return;
    }
    widget.grocery.name = itemName;
    widget.grocery.quantity = quantity;
    widget.grocery.category = categoryValue;
    widget.grocery.measurementUnit = measurementUnitValue;

    if(widget.isNewGrocery){
      widget.addNewGroceryItem(widget.grocery);
    }else{
      widget.editGroceryItem(widget.grocery);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    quantityFocusNode = FocusNode();
    categoryFocusNode = FocusNode();

    _itemNameController.text = widget.grocery.name;
    _quantityController.text = widget.grocery.quantity;
    categoryValue = widget.grocery.category.isEmpty ? Categories.categories[0] : widget.grocery.category;
    measurementUnitValue = widget.grocery.measurementUnit.isEmpty ? MeasurementUnits.units[0] : widget.grocery.measurementUnit;
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    categoryFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.isNewGrocery ? "Add" : "Edit" } Grocery Item"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: "Name"),
              controller: _itemNameController,
              onSubmitted: (_) => quantityFocusNode.requestFocus(),
            ),
            SizedBox(height: 15.0,),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  Flexible(
                    child: TextField(
                      focusNode: quantityFocusNode,
                      decoration: InputDecoration(labelText: "Quantity", contentPadding: EdgeInsets.all(6.0)),
                      controller: _quantityController,
                      onSubmitted: (_) => categoryFocusNode.requestFocus(),
                    ),
                  ),

                  Container(
                    width: 50.0,
                    child: DropdownButtonFormField<String>(
                      value: measurementUnitValue,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0)
                      ),

                      items: MeasurementUnits.units.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          measurementUnitValue = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0,),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: categoryValue,
              items: Categories.categories.map((String value) {
                return new DropdownMenuItem<String>(

                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  categoryValue = newValue;
                });
              },
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text("${widget.isNewGrocery ? "Add" : "Edit" }"

              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
