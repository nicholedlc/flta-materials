// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  // Requires a `GroceryManager` so it can get the list of grocery items to display in the list
  final GroceryManager manager;

  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // Wrap `Inkwell` inside a `Dismissible`, a widget that clears an item from the list
          return Dismissible(
            // The dismissible widget requires a `Key` so that Flutter
            // can find and remove the right element in the tree
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            // Use a red background widget with a white trash can `Icon`
            // aligned in the center and to the right of the `Container`
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} dismissed'),
                ),
              );
            },
            // Wrap gesture widgets (e.g. `Inkwell`) around other widgets that need touch behavior.
            child: InkWell(
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
              ),
              // When the gesture recognizes a tap, it presents `GroceryItemScreen`,
              // letting the user edit the current item.
              onTap: () {
                Navigator.push(
                  context,
                  // `MaterialPageRoute` returns an instance of your new screen widget.
                  // Navigator returns the result of the push whenever the screen pops off the stack
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      // `GroceryItemScreen` calls `onUpdate` whent he user updates an item
                      onUpdate: (item) {
                        // `GroceryManager` updates the item at the particular index
                        manager.updateItem(item, index);
                        // Dimisses `GroceryItemScreen`
                        Navigator.pop(context);
                      },
                      // `onCreate` will not be called since you are updating an existing item
                      onCreate: (item) {},
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
