class AppLink {
  static const String kHomePath = '/home';
  static const String kOnboardingPath = '/onboarding';
  static const String kLoginPath = '/login';
  static const String kProfilePath = '/profile';
  static const String kItemPath = '/item';

  static const String kTabParam = 'tab';
  static const String kIdParam = 'id';

  String location;

  int? currentTab;

  String? itemId;

  AppLink({required this.location, this.currentTab, this.itemId});

  static AppLink fromLocation(String location) {
    location = Uri.decodeFull(location);
    final uri = Uri.parse(location);
    final params = uri.queryParameters;
    void trySet(String key, void Function(String) setter) {
      if (params.containsKey(key)) setter?.call(params[key]!);
    }

    final link = AppLink(location: uri.path);
    trySet(AppLink.kTabParam, (s) => link.currentTab = int.tryParse(s));
    trySet(AppLink.kIdParam, (s) => link.itemId = s);
    return link;
  }

  String toLocation() {
    String addKeyValPair({required String key, String? value}) =>
        value == null ? '' : '${key}=$value&';
    switch (location) {
      case kLoginPath:
        return kLoginPath;
      case kOnboardingPath:
        return kOnboardingPath;
      case kProfilePath:
        return kProfilePath;
      case kItemPath:
        var loc = '$kItemPath?';
        loc += addKeyValPair(key: kIdParam, value: itemId);
        return Uri.encodeFull(loc);
      default:
        var loc = '$kHomePath?';
        loc += addKeyValPair(key: kTabParam, value: currentTab.toString());
        return Uri.encodeFull(loc);
    }
  }
}
