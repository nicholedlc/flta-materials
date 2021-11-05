import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  // Require a list of `Post`s
  final List<Post> friendPosts;

  const FriendPostListView({
    Key? key,
    required this.friendPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Social Chefs 🧑‍🍳',
                style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 16),
            // Create `ListView.separated` with 2 `IndexWidgetBuilder` callbacks
            ListView.separated(
              // Since you're nesting 2 list views, it's a good idea to set `primary`
              // to false to let flutter know that this isn't the primary scroll view.
              primary: false,
              // Even though you set `primary` to false, it's also a good idea
              // to disable the scrolling for this list view.
              // That will propagate up to the parent list.
              physics: const NeverScrollableScrollPhysics(),
              // If this were false, you'd get an unbounded height error.
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: friendPosts.length,
              itemBuilder: (context, index) {
                final post = friendPosts[index];
                return FriendPostTile(post: post);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            ),
            // Leave some padding at the end of the list
            const SizedBox(height: 16),
          ],
        ));
  }
}
