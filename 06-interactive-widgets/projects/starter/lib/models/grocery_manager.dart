// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'grocery_item.dart';

// `GroceryManager` extends `ChangeNotifier` to notify its listener about state changes.
class GroceryManager extends ChangeNotifier {
  // This manager holds a private array of `_groceryItems`.
  // Only the manager can change and update grocery items.
  final _groceryItems = <GroceryItem>[];

  // Provides a public getter method for `groceryItems`, which is unmodifiable.
  // External entities can only read the list of grocery items
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  // Deletes an item at a particular index
  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  // Adds a new grocery item at the end of the list
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  // Replaces the old item at a given index with a new item
  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  // Toggles the `isComplete` flag on and off
  void completedItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
