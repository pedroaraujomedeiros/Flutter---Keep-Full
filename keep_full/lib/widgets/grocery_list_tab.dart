import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/widgets.dart';
import '../Models/models.dart';
import '../Blocs/blocs.dart';

class GroceryListTab extends StatefulWidget {
  @override
  _GroceryListTabState createState() => _GroceryListTabState();
}

class _GroceryListTabState extends State<GroceryListTab> {
  final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroceryListBloc, GroceryListState>(
      listener: (context, state) {
        Scaffold.of(context).removeCurrentSnackBar();
        if (state is AddedSuccess) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text("Item added"),
              ),
            );
        } else if (state is EditedSuccess) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text("Item Edited"),
              ),
            );
        } else if (state is DeletedSuccess) {
          Scaffold.of(context)
            ..showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text("Item Deleted"),
              ),
            );
        }
      },
      child: BlocBuilder<GroceryListBloc, GroceryListState>(
        builder: (context, state) {
          GroceryList groceryList =
              BlocProvider.of<GroceryListBloc>(context).groceryList;
          if (state is Loading) {
            return Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    'Loading Items...',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            );
          } else if (groceryList.items.length == 0) {
            return Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
              child: Center(
                child: Text(
                  'No items added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: groceryList.items.length,
                itemBuilder: (ctx, idx) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
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
                            onTap: () {
                              BlocProvider.of<GroceryListBloc>(context).add(
                                  ItemDeleted(grocery: groceryList.items[idx]));
                            }),
                      ],
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<GroceryItem>(
                              builder: (_) {
                                return BlocProvider<GroceryListBloc>.value(
                                    value:
                                        BlocProvider.of<GroceryListBloc>(context),
                                    child: GroceryItem(groceryList.items[idx],
                                        ActionGroceryItem.Edit));
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            groceryList.items[idx].name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(
                            "${groceryList.items[idx].category} - ${groceryList.items[idx].quantity}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<GroceryItem>(
                                  builder: (_) {
                                    return BlocProvider<GroceryListBloc>.value(
                                        value: BlocProvider.of<GroceryListBloc>(
                                            context),
                                        child: GroceryItem(groceryList.items[idx],
                                            ActionGroceryItem.Edit));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        }
      ),
    );
  }
}
