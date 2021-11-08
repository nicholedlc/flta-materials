// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class RecipesGridView extends StatelessWidget {
  // Require a list of recipes to display in a grid
  final List<SimpleRecipe> recipes;

  const RecipesGridView({
    Key? key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      // Displays only the items visible onscreen
      child: GridView.builder(
        // Tell the grid view how many items will be in the grid
        itemCount: recipes.length,
        // This means that there will be only 2 columns
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          // Making maxCrossAxisExtent greater than the device’s width would allow for only one column
          maxCrossAxisExtent: 500,
        ),
        // const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        // For every index, fetch the recipe and create a corresponding `RecipeThumbnail`
        itemBuilder: (context, index) {
          final simpleRecipe = recipes[index];
          return RecipeThumbnail(recipe: simpleRecipe);
        },
      ),
    );
  }
}
