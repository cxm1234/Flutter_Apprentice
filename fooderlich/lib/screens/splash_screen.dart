import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  static MaterialPage page() {
    return MaterialPage(
        name: FooderlichPages.splashPath,
        key: ValueKey(FooderlichPages.splashPath),
        child: const SplashScreen()
    );
  }
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializedApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(height: 200,
            image: AssetImage('assets/fooderlich_assets/rw_logo.png'),),
            Text('Initializing...'),
          ],
        ),
      )
    );
  }

}