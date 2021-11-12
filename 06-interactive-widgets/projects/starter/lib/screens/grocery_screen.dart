// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'empty_grocery_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adds a floating action button with a `+` icon.
      // Tapping the button presents the screen to create or add an item.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO 11: Present GroceryItemsScreen
        },
      ),
      // Builds the rest of the Grocery screen's subtree.
      body: buildGroceryScreen(),
    );
  }

  // `buildGroceryScreen()` is a helper function that decides which widget tree to construct.
  Widget buildGroceryScreen() {
    // Wraps widget inside `Consumer`, which listens for `GroceryManager` state changes.
    return Consumer<GroceryManager>(
      // Consumer rebuilds the widgets below itself when the grocery manager items changes.
      // Tip: You should only wrap a Consumer around widgets that need it. For example,
      // wrapping a consumer widget at the top level would force it to rebuild the entire tree!
      builder: (context, manager, child) {
        // If there are grocery items in the list, show the `GroceryListScreen`.
        if (manager.groceryItems.isNotEmpty) {
          // TODO 25: Add GroceryListScreen
          return Container();
          // If there are no groceryItems, show the `EmptyGroceryScreen`
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
