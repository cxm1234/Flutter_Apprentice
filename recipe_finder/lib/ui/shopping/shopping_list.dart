import 'package:flutter/cupertino.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  final ingredients = <String>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(itemBuilder: itemBuilder)
  }
}