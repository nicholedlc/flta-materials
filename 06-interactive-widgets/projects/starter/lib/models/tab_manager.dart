// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

// `TabManager` extends `ChangeNotifier` to allow the object to provide change notifications to its listeners (using `notifyListeners()`?)
class TabManager extends ChangeNotifier {
  // Keeps track of which tabe the user tapped
  int selectedTab = 0;

  // A simple function that modifies the current tab index
  void goToTab(index) {
    // Stores the index of the new tab the user tapped
    selectedTab = index;
    // Notify all widgets listening to this state
    notifyListeners();
  }

  // Sets `selectedTab to the Recipes tab, which is at index 1
  void goToRecipes() {
    selectedTab = 1;
    // Notify all widgets listening to TabManager that Recipes is the selected tab
    notifyListeners();
  }
}
