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
    // Runs an asynchronous task and lets you know the state of the future.
    return FutureBuilder(
        // `getExploreData() creates a future that will return an ExploreData instance`.
        // That instance will contain 2 lists: `todayRecipes` and `friendPosts`.
        future: mockService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          // Check the current state of the future. If the future is complete:
          if (snapshot.connectionState == ConnectionState.done) {
            // When the future is complete, return the primary `ListView`, which holds an explicit list of children (ie.e. the other 2 `ListView`s)
            return ListView(
              // Vertical is the default value for `scrollDirection`
              scrollDirection: Axis.vertical,
              children: [
                TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
                const SizedBox(height: 16),
                // Use a green placeholder container
                Container(
                  height: 400,
                  color: Colors.green,
                )
              ],
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
