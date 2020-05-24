import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../Blocs/grocery_list/bloc.dart';
import '../../Models/models.dart';

class GroceryListBloc extends Bloc<GroceryListEvent, GroceryListState> {
  GroceryList groceryList = GroceryList();

  GroceryListBloc(this.groceryList);

  @override
  get initialState {
    return ActionSuccess();
  }

  @override
  Stream<GroceryListState> mapEventToState(GroceryListEvent event) async* {
    if (event is LoadFromDatabase) {
      yield* _mapLoadFromDatabaseToState(event);
    } else if (event is ItemAdded ||
        event is ItemDeleted ||
        event is ItemEdited) {
      yield* _mapActionEventToState(event);
    } else {
      yield ActionFailure();
    }
  }

  Stream<GroceryListState> _mapLoadFromDatabaseToState(
      GroceryListEvent event) async* {
    try {
      yield Loading();
      this.groceryList.items = await GroceryList.dbQueryAllRows();
      yield Load();
    } catch (_) {
      yield ActionFailure();
    }
  }

  Stream<GroceryListState> _mapActionEventToState(
      GroceryListEvent event) async* {
    try {
      if (event is ItemAdded) {
        await groceryList.addItem(event.grocery);
        yield AddedSuccess(event.grocery);
      } else if (event is ItemEdited) {
        yield Loading();
        await groceryList.editItem(event.grocery);
        yield EditedSuccess(event.grocery);

      } else if (event is ItemDeleted) {
        yield Loading();
        await groceryList.deleteItem(event.grocery);
        yield DeletedSuccess(event.grocery);
      }
    } catch (_) {
      yield ActionFailure();
    }
  }
}
