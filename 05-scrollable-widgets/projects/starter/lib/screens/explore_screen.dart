// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatelessWidget {
  // Mock server responses
  final mockService = MockFooderlichService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO 1: Add TodayRecipeListView FutureBuilder
    // The `FutureBuilder` takes in a Future as a parameter.
    return FutureBuilder(
        // `getExploreData() creates a future that will, return an ExploreData instance`.
        // That instance will contain 2 lists: `todayRecipes` and `friendPosts`.
        future: mockService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          // Check the current state of the future. If the future is complete:
          if (snapshot.connectionState == ConnectionState.done) {
            // `snapshot.data` returns `ExploreData`, from which `todayRecipes` is extracted to pass to the list view.
            final recipes = snapshot.data?.todayRecipes ?? [];
            return Center(
              child: Container(
                child: const Text('Show TodayRecipeListView'),
              ),
            );
            // If the future is still loading, show a spinner
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
