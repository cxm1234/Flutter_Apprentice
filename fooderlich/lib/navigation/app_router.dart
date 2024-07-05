import 'package:flutter/cupertino.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/screens/login_screen.dart';
import 'package:fooderlich/screens/splash_screen.dart';

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
        // TODO: Add OnboardingScreen
        // TODO: Add Home
        // TODO: Create new item
        // TODO: Select GroceryItemScreen
        // TODO: Add Profile Screen
        // TODO: Add WebView Screen
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

    // TODO: Handle Onboarding and splash
    // TODO: Handle state when user closes grocery item screen
    // TODO: Handle state when user closes profile screen
    // TODO: Handle state when user closes WebView screen

    return true;
  }
  @override
  Future<void> setNewRoutePath(configuration) async => null;

}

