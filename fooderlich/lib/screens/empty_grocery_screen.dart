import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class EmptyGroceryScreen extends StatelessWidget {

  const EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset('assets/fooderlich_assets/empty_list.png'),
            ),
              const SizedBox(height: 8.0,),
              const Text('No Groceries', style: TextStyle(fontSize: 21.0),),
              const SizedBox(height: 16.0,),
              const Text(
                'Shopping for ingredients?\n'
                    'Tap the + button to write them down!',
                textAlign: TextAlign.center,
              ),
               MaterialButton(
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.green,
                 onPressed: () {
                   Provider.of<AppStateManager>(context, listen: false).goToRecipes();
                 },
                child: const Text('Browse Recipes'),
              )
      ],)),
    );
  }
}