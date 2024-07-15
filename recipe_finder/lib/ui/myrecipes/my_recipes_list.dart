import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/data/repository.dart';
import 'package:recipe_finder/data/models/recipe.dart';

class MyRecipesList extends StatefulWidget {
  const MyRecipesList({super.key});

  @override
  _MyRecipesListState createState() => _MyRecipesListState();
}

class _MyRecipesListState extends State<MyRecipesList> {

  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildRecipeList(context),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<List<Recipe>>(
        stream: repository.watchAllRecipes(),
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final recipes = snapshot.data ?? [];
            return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  final recipe = recipes[index];
                  return SizedBox(
                    height: 100,
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              deleteRecipe(repository, recipe);
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              deleteRecipe(repository, recipe);
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: recipe.image,
                                height: 120,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              // TODO 6
                              title: Text(recipe.label),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          } else {
            return Container();
          }
        }
    );
    // TODO 9
  }

  void deleteRecipe(Repository repository, Recipe recipe) async {
    final recipeId = recipe.id;
    if (recipeId != null) {
      repository.deleteRecipeIngredients(recipeId);
    }
    repository.deleteRecipe(recipe);
    setState(() {});
  }

}