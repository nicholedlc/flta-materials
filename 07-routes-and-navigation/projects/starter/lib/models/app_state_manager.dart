import 'dart:async';
import 'package:flutter/material.dart';

// Creates constants for each tab the user taps
class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

// `AppStateManager` manages the app's navigation state
class AppStateManager extends ChangeNotifier {
  // Checks if the app is initialized
  bool _initialized = false;
  // Checks if the user has logged in
  bool _loggedIn = false;
  // Checks if the user completed the onboarding flow
  bool _onboardingComplete = false;
  // Keeps track of which tab the user is on
  int _selectedTab = FooderlichTab.explore;

  // These are getter methods for each property. You cannot change these
  // properties outside `AppStateManager`. This is important for the
  // unidirectional flow architecture, where you don't change state directly
  // but only via function calls or dispatched events (functions set some values
  // that aren't publicly explosed and then notify listeners)
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    Timer(
      // Sets a delayed timer for 2000ms before executing the closure. This
      // sets how long the app screen will display after user starts the app.
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void login(String username, String password) {
    // In a real scenario, you’d make an API request to log in.
    // In this case, however, you’re just using a mock.
    _loggedIn = true;
    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() {
    // Resets all app state properties
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;

    initializeApp();
    notifyListeners();
  }
}
