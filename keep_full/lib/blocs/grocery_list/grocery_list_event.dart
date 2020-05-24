import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../Models/models.dart';

@immutable
abstract class  GroceryListEvent extends Equatable{
  final Grocery grocery;

  const GroceryListEvent({@required this.grocery});

  @override
  List<Object> get props => [grocery];
}

class LoadFromDatabase extends GroceryListEvent{
  @override
  String toString() => 'LoadFromDatabase';
}
/// Event ItemAdded
class ItemAdded extends GroceryListEvent {

  const ItemAdded({@required Grocery grocery}) : super(grocery: grocery);

  @override
  String toString() => 'ItemAdded';
}

/// Event ItemDeleted
class ItemDeleted extends GroceryListEvent {

  const ItemDeleted({@required Grocery grocery}) : super(grocery: grocery);

  @override
  String toString() => 'ItemDeleted';
}

/// Event Edited
class ItemEdited extends GroceryListEvent {

  const ItemEdited({@required Grocery grocery}) : super(grocery: grocery);

  @override
  String toString() => 'ItemEdited';
}