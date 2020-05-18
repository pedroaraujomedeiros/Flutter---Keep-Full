import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../Models/Grocery.dart';


class GroceryListTab extends StatelessWidget {
  final List<Grocery> groceries;
  final Function showGrocery;
  final Function editGrocery;
  final Function deleteGrocery;
  final SlidableController slidableController = SlidableController();

  GroceryListTab(this.groceries, this.showGrocery, this.editGrocery, this.deleteGrocery);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height ,
          child: groceries.length == 0
              ? Center(
            child: Text(
              'No items added yet!',
              style: Theme.of(context).textTheme.headline6,
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            itemCount: groceries.length,
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.5,
                  ),
                ),
                child: Slidable(
                  controller: slidableController,
                  direction: Axis.horizontal,
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => this.deleteGrocery(groceries[idx]),
                    ),

                  ],
                  
                  child: ListTile(
                    title: Text(
                      groceries[idx].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      "${groceries[idx].category} - ${groceries[idx].quantity}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        this.showGrocery(context,groceries[idx]);
                        //this.editGrocery(groceries[idx].groceryId);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
