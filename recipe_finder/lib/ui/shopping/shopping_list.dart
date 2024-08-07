import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/data/repository.dart';

class ShoppingList extends StatelessWidget {

  ShoppingList({super.key});
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    return StreamBuilder(
        stream: repository.watchAllIngredients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final ingredients = snapshot.data;
            if (ingredients == null) {
              return Container();
            }
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
          } else {
            return Container();
          }
        });
  }
}