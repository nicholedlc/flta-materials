class AppLink {
  // Create constants for each URL path
  static const String homePath = '/home';
  static const String onboardingPath = '/onboarding';
  static const String loginPath = '/login';
  static const String profilePath = '/profile';
  static const String itemPath = '/item';
  // Create constants for each of the query parameters you'll support
  static const String tabParam = 'tab';
  static const String idParam = 'id';
  // Store the path of the URL using `location`
  String? location;
  // Use `currentTab` to store the tab you want to redirect the user to
  int? currentTab;
  // Store the ID of the item you want to view in `itemId`
  String? itemId;

  // Initialize AppLink with the lcoation and the two query parameters
  AppLink({this.location, this.currentTab, this.itemId});

  static AppLink fromLocation(String? location) {
    print('loc 1 => $location');
    // You need to decode the URL. URLs often include special characters
    // in their paths, so you need to percent-encode the URL path.
    // For example, you’d encode `hello!world` to `hello%21world`.
    location = Uri.decodeFull(location ?? '');
    print('loc 2 => $location');
    // Parse the URI for query parameter keys and key-value pairs.
    final uri = Uri.parse(location);
    print('uri => $uri');
    final params = uri.queryParameters;
    print('params => $params');

    // Extract the currentTab from the URL path if it exists
    final currentTab = int.tryParse(params[AppLink.tabParam] ?? '');
    // Extract the itemId from the URL path if it exists.
    final itemId = params[AppLink.idParam];
    // Create the AppLink by passing in the query parameters you extract
    // from the URL string.
    final link = AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );
    // Return the instance of AppLink.
    return link;
  }

  String toLocation() {
    // Create an internal function that formats the query parameter
    // key-value pair into a string format.
    String addKeyValPair({required String key, String? value}) =>
        value == null ? '' : '$key=$value&';

    print('location | $location');
    switch (location) {
      case loginPath:
        return loginPath;
      case onboardingPath:
        return onboardingPath;
      case profilePath:
        return onboardingPath;
      case itemPath:
        // Return the string path `/item`, and if there are any parameters, append ?id=${id}.
        var loc = '$itemPath?';
        loc += addKeyValPair(key: idParam, value: itemId);
        return Uri.encodeFull(loc);
      // If the path is invalid, default to the path /home. If the user selected a tab, append ?tab=${tabIndex}.
      default:
        var loc = '$homePath?';
        loc += addKeyValPair(key: tabParam, value: currentTab.toString());
        return Uri.encodeFull(loc);
    }
  }
}
