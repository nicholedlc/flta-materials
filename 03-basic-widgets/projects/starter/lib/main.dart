import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';
import 'home.dart';

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
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      home: const Home(),
    );
  }
}
