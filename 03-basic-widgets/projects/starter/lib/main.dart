import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

void main() {
  // 1
  // Everything in Flutter starts with a widget.
  //`runApp()` takes in the root widget Fooderlich.
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  // 2
  // constructor({ key }) {
  //   super({ key })
  // }
  const Fooderlich({Key? key}) : super(key: key);
  // Every stateless widget must override the build method.
  @override
  Widget build(BuildContext context) {
    // Define the variable that holds the theme
    final theme = FooderlichTheme.dark();
    // TODO: Apply Home widget
    // 3
    // Compose a `MaterialApp` widget to give it a Material Design system look and feel
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      // 4
      // `Scaffold` widget defines the layout and structure of the app
      home: Scaffold(
        // TODO: Style the title
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: theme.textTheme.headline6,
          ),
        ),
        body: Center(
          child: Text(
            'Let\'s get cooking 👩‍🍳',
            style: theme.textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
