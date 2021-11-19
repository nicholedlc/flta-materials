import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

// The system will tell the router to build and configure a navigator widget
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  // Declares `GlobalKey`, a unique key across the entire app
  final GlobalKey<NavigatorState> navigatorKey;

  // The router will listen to app state changes to configure the navigator's
  // list of pages
  final AppStateManager appStateManager;
  // Listens to the user's state when you create or edit an item
  final GroceryManager groceryManager;
  // Listens to the user profile state
  final ProfileManager profileManager;

  // AppRouter(appStateManager, groceryManager, profileManager) {
  //   this.appStateManager = appStateManager;
  //   this.groceryManager = groceryManager;
  //   this.profileManager = profileManager;

  //   navigatorKey = GlobalKey<NavigatorState>();
  //   // TODO: Add Listeners
  // }
  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    // TODO: Add Listeners
  }

  // TODO: Dispose listeners

  // `RouterDelegate` requires you to add a `build()`.
  // This configures your navigator and pages.
  @override
  Widget build(BuildContext context) {
    // Configures a `Navigator`
    return Navigator(
      // Uses `navigatorKey` - required to retrieve the current navigator
      key: navigatorKey,
      // Call `_handlePopPage` every time a page pops from the stack
      onPopPage: _handlePopPage,
      // The stack of pages that describes your navigation stack
      pages: [
        // TODO: Add SplashScreen
        // TODO: Add LoginScreen
        // TODO: Add OnboardingScreen
        // TODO: Add Home
        // TODO: Create new item
        // TODO: Select GroceryItemScreen
        // TODO: Add Profile Screen
        // TODO: Add WebView Screen
      ],
    );
  }

  // When the user taps the Back button or triggers a system back button event,
  // it fires a helper method, `onPopPage`.
  bool _handlePopPage(
    // This is the current `Route`, which contains information like
    // `RouteSettings` to retrieve the route's name and arguments
    Route<dynamic> route,
    // `result` is the value that returns when the route completes -
    // for example, a value that that a dialog returns
    result,
  ) {
    // Checks if the current route's pop failed
    if (!route.didPop(result)) {
      return false;
    }

    // If the route pop succeeds, this checks the different routes and triggers
    // the appropriate state changes
    // TODO: Handle Onboarding and splash
    // TODO: Handle state when user closes grocery item screen
    // TODO: Handle state when user closes profile screen
    // TODO: Handle state when user closes WebView screen

    return true;
  }

  // Sets `setNewRoutePath` to `null` since you aren't supporting Flutter web
  // apps yet.
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}

// Note: How is this declarative? Instead of telling the navigator what to do
// with push() and pop(), you tell it: when the state is x, render y pages.
