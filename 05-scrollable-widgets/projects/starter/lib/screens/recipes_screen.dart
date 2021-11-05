import 'package:flutter/material.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class RecipesScreen extends StatelessWidget {
  // Create a mock service
  final exploreService = MockFooderlichService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext build) {
    return FutureBuilder(
      // Return a future list of `SimpleRecipe`s to display
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        // Check if the future is complete
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
          // Show a circular loading indicator if the future isn't completed yet
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
