import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/screens/empty_grocery_screen.dart';
import 'package:fooderlich/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';

import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Provider.of<GroceryManager>(context, listen: false).createNewItem();
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        return GroceryListScreen(manager: manager);
      } else {
        return const EmptyGroceryScreen();
      }
    });
  }
}