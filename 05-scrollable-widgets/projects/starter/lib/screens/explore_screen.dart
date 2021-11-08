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
    _controller = ScrollController();
    _controller.addListener(scrollListener);

    super.initState();
  }

  // The framework calls dispose() when you permanently remove the object and its state from the tree. It’s important to remember to handle any memory cleanup, such as unsubscribing from streams and disposing of animations or controllers. In this case, you’re removing the scroll listener.
  @override
  void dispose() {
    _controller.removeListener(scrollListener);

    super.dispose();
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

  void scrollListener() {
    print('scrolling... OFFSET: ${_controller.offset}');
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('i am at the bottom!');
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('i am at the top!');
    }
  }
}
