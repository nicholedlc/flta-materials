import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../screens/screens.dart';

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

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    // Connect the state managers. When the state changes, the router will
    // reconfigure the navigator with a new set of pages:

    // Determines the state of the app. It manages whether the app
    // initialized login and if the user completed the onboarding
    appStateManager.addListener(notifyListeners);
    // Manages the list of grocery items and the item selection state
    groceryManager.addListener(notifyListeners);
    // Manages the user's profile and settings
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);

    super.dispose();
  }

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
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),
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

    // If the user taps the Back button from the Onboarding screen, it calls
    // `logout()`. This resets the entire app state and user had to log in again
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }
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
