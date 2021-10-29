import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key}) : super(key: key);

  // Define string variables to display on the card.
  // This is just a sample data to help build the card
  final String category = "Editor's Choice";
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';

  // Every stateless widget comes with a `build()` method that you override
  @override
  Widget build(BuildContext context) {
    // Start with a container laid out in the center
    return Center(
      child: Container(
        child: Stack(
          children: [
            Text(
              category,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
            // The `Position` widget controls where you position the text in the `Stack`.
            // Place the title 20 pixels from the top
            Positioned(
              child: Text(
                title,
                style: FooderlichTheme.darkTextTheme.headline2,
              ),
              top: 20,
            ),
            // Place the description 30 pixels from the bottom and 0 to the right
            Positioned(
              child: Text(
                description,
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
              bottom: 30,
              right: 0,
            ),
            // Position the chef's name 10 pixels from the bottom-right
            Positioned(
              child: Text(
                chef,
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
              bottom: 10,
              right: 0,
            )
          ],
        ),
        // Apply a padding of 16 on all sides of the box.
        // Flutter units are specified in logical pixels
        padding: const EdgeInsets.all(16),
        // Constrain the container's size to a width of 350 and a height of 450
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        // Apply `BoxDecoration`. This describes how to draw a box.
        decoration: const BoxDecoration(
          // `DecorationImage` tells the box to paint an image
          image: DecorationImage(
            // Set which image to paint in the box using an `AssetImage`
            image: AssetImage('assets/mag1.png'),
            // Cover the entire box with that image
            fit: BoxFit.cover,
          ),
          // Apply a corner radius of 10 to all sides of the container
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
