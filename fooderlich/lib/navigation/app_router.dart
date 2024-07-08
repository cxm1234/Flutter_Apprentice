import 'package:flutter/cupertino.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';
import 'package:fooderlich/screens/home.dart';
import 'package:fooderlich/screens/login_screen.dart';
import 'package:fooderlich/screens/onboarding_screen.dart';
import 'package:fooderlich/screens/profile_screen.dart';
import 'package:fooderlich/screens/splash_screen.dart';
import 'package:fooderlich/screens/webview_screen.dart';

class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager
  }): navigatorKey = GlobalKey<NavigatorState>() {
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
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn) LoginScreen.page(),
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete) OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete) Home.page(appStateManager.getSelectedTab),
        if (groceryManager.isCreatingNewItem) 
          GroceryItemScreen.page(
            onCreate: (item) {
              groceryManager.addItem(item);
            },
            index: groceryManager.selectedIndex ?? 0,
            onUpdate: (groceryItem , index) {  },
          ),
        if (groceryManager.selectedIndex != null)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onCreate: (item) {},
              onUpdate: (item, index) {
              groceryManager.updateItem(item, index);
          }),

        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),

        if (profileManager.didTapOnRaywenderlich)
          WebViewScreen.page(),
      ],
    );
  }

  // TODO: Add _handlePopPage
  bool _handlePopPage(
      Route<dynamic> route,
      result
      ) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(null);
    }

    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }
  @override
  Future<void> setNewRoutePath(configuration) async => null;

}

