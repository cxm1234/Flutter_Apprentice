import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/home.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();
    return MaterialApp(
      theme: theme,
      title:  'Fooderlich',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => GroceryManager())
        ],
        child: const Home(),
      )
    );
  }
}