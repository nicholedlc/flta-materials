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
          // Wrap gesture widgets (e.g. `Inkwell`) around other widgets that need touch behavior.
          return InkWell(
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
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
