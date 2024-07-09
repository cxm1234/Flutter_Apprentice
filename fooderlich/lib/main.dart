import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/navigation/app_route_parser.dart';
import 'package:fooderlich/navigation/app_router.dart';
import 'package:provider/provider.dart';

import 'models/profile_manager.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {

  const Fooderlich({super.key});

  @override
  _FoolderlichState createState() => _FoolderlichState();
}

class _FoolderlichState extends State<Fooderlich> {

  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;
  final routeParser = AppRouteParser();

  @override
  void initState() {
    _appRouter = AppRouter(
        appStateManager: _appStateManager,
        groceryManager: _groceryManager,
        profileManager: _profileManager
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (context) => _groceryManager),
      ChangeNotifierProvider(create: (context) => _profileManager),
      ChangeNotifierProvider(create: (context) => _appStateManager)
    ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, chiild) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp.router(
            theme: theme,
            title: 'Fooderlich',
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: routeParser,
            routerDelegate: _appRouter,
          );
        },
      ),
    );
  }
}