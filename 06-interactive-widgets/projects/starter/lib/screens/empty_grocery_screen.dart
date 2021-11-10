// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // `Flexible` gives a child the ability to fill the available space in the main axis
            Flexible(
              // Although `aspectRatio` is a double, the Flutter documentation recommends writing it as `width/height` instead of the calculated result.
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              ),
            ),
            const Text(
              'No Groceries',
              style: TextStyle(fontSize: 21.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              textColor: Colors.white,
              child: const Text('Browse Recipes'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.green,
              onPressed: () {
                // Use `Provider.of()` to access the model object, `TabManager`.
                // `goToRecipes()` sets the index to the Recipes tab.
                // This notifies `Consumer` to rebuild `Home` with the right tab index.
                Provider.of<TabManager>(context, listen: false).goToRecipes();
              },
            ),
          ],
        ),
      ),
    );
  }
  // TODO: Add buildGroceryScreen
}
