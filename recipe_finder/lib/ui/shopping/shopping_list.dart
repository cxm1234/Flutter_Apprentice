import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/data/memory_repository.dart';

class ShoppingList extends StatelessWidget {

  ShoppingList({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryRepository>(builder: (context, repository, child) {
      final ingredients = repository.findAllIngredients();
      return ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: false,
              title: Text(ingredients[index].name),
              onChanged: (newValue) {},
            );
          }
      );
    });
  }
}