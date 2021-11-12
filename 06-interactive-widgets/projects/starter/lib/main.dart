// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'home.dart';
import 'models/models.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      // Assign `MultiProvider` as a property of `home`. This accepts
      // a list of providers for `Home`'s descendant widgets to access
      home: MultiProvider(
        providers: [
          // `ChangeNotifierProvider` creates an instance of `TabManager`,
          //  which listens to tab index changes and notifies its listeners
          ChangeNotifierProvider(create: (context) => TabManager()),
          // All descendent widgets of Fooderlich can now listen to or acccess `GroceryManager`
          ChangeNotifierProvider(create: (context) => GroceryManager()),
        ],
        child: const Home(),
      ),
    );
  }
}
