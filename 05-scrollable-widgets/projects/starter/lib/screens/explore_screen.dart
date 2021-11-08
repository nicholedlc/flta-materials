// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatefulWidget {
  // Mock server responses

  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mockService = MockFooderlichService();
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    final scrollListener = () {
      print('scrolling...');
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          print('i am at the top!');
        } else {
          print('i am at the bottom!');
        }
      }
    };
    _controller.addListener(scrollListener);
  }

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
              controller: _controller,
              // Vertical is the default value for `scrollDirection`
              scrollDirection: Axis.vertical,
              children: [
                TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
                const SizedBox(height: 16),
                FriendPostListView(
                    friendPosts: snapshot.data?.friendPosts ?? []),
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
