import 'package:equatable/equatable.dart';
import 'package:keep_full/Widgets/grocery_item.dart';
import 'package:meta/meta.dart';

import '../../Models/models.dart';

@immutable
abstract class  GroceryListState extends Equatable{
  const GroceryListState();
  @override
  List<Object> get props => [];
}

class Loading extends GroceryListState{
  @override
  String toString() => 'Loading';
}

/// Load
class Load extends GroceryListState{
  //final List<Grocery> groceries;

  //const Load(this.groceries);

  @override
  //List<Object> get props => [groceries];

  @override
  String toString() => 'Load';
}


/// State ActionSuccess
class ActionSuccess extends GroceryListState {
  @override
  String toString() => 'ActionSuccess';
}

/// State ActionFailure
class ActionFailure extends GroceryListState {
  @override
  String toString() => 'ActionFailure';
}

/// State AddedSuccess
class AddedSuccess extends GroceryListState {
  final Grocery item;

  const AddedSuccess(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'AddedSuccess';
}

/// State AddedFailure
class AddedFailure extends GroceryListState {
  @override
  String toString() => 'AddedFailure';
}


/// State EditedSuccess
class EditedSuccess extends GroceryListState {
  final Grocery item;

  const EditedSuccess(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'EditedSuccess';
}

/// State EditedFailure
class EditedFailure extends GroceryListState {
  @override
  String toString() => 'EditedFailure';
}


/// State DeletedSuccess
class DeletedSuccess extends GroceryListState {
  final Grocery item;

  const DeletedSuccess(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'DeletedSuccess';
}

/// State DeletedFailure
class DeletedFailure extends GroceryListState {
  @override
  String toString() => 'DeletedFailure';
}


