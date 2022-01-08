import 'package:flutter/material.dart';
import 'package:fooderlich/navigation/app_link.dart';

import '../models/models.dart';
import '../screens/screens.dart';

// Set the RouterDelegate’s user-defined data type to AppLink.
class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LoginScreen.page(),
        ] else if (!appStateManager.isOnboardingComplete) ...[
          OnboardingScreen.page(),
        ] else ...[
          Home.page(appStateManager.getSelectedTab),
          if (groceryManager.isCreatingNewItem)
            GroceryItemScreen.page(onCreate: (item) {
              groceryManager.addItem(item);
            }, onUpdate: (item, index) {
              // No update
            }),
          if (groceryManager.selectedIndex != -1)
            GroceryItemScreen.page(
                item: groceryManager.selectedGroceryItem,
                index: groceryManager.selectedIndex,
                onCreate: (_) {
                  // No create
                },
                onUpdate: (item, index) {
                  groceryManager.updateItem(item, index);
                }),
          if (profileManager.didSelectUser)
            ProfileScreen.page(profileManager.getUser),
          if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
        ]
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  // This is a helper function that converts the app state to an AppLink object.
  AppLink getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.loginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.onboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.profilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.itemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.itemPath, itemId: id);
    } else {
      return AppLink(
        location: AppLink.homePath,
        currentTab: appStateManager.getSelectedTab,
      );
    }
  }

  // Accessing currentConfiguration calls the helper, getCurrentPath(),
  // which checks the app state and returns the right app link configuration.
  @override
  AppLink get currentConfiguration => getCurrentPath();

  @override
  // You call setNewRoutePath() when a new route is pushed.
  // It passes along an AppLink. This is your navigation configuration.
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.profilePath:
        profileManager.tapOnProfile(true);
        break;
      case AppLink.itemPath:
        final itemId = newLink.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(false);
        break;
      case AppLink.homePath:
        print('CURRENT TAB: ${newLink.currentTab}');
        appStateManager.goToTab(newLink.currentTab ?? 0);
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(-1);
        break;
      default:
        break;
    }
  }
}

/*
Here is the process that goes from a URL to an app state:

1. The user enters a new URL in the web browser’s address bar.
2. RouteInformationParser parses the new route into your navigation state,
an instance of AppLink.
3. Based on the navigation state, RouterDelegate updates the app state
to reflect the new changes.
*/

/*
1. When the user presses a button or modifies a state, notifyListeners() fires.
2. RouteInformationParser asks for the current navigation configuration,
so you must convert your app state to an AppLink.
3. RouteInformationParser then calls restoreRouteInformation and
converts AppLink to a URL string.
*/ 