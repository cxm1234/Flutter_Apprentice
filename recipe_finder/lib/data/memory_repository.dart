import 'dart:core';
import 'dart:async';
import 'repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository {

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }

  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;

  final StreamController _recipeStreamController = StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController = StreamController<List<Ingredient>>();

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    _recipeStream ??= _recipeStreamController.stream as Stream<List<Recipe>>;
    return _recipeStream!;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    _ingredientStream ??= _ingredientStreamController.stream as Stream<List<Ingredient>>;
    return _ingredientStream!;
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return Future.value(_currentRecipes);
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe = _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = _currentIngredients.where((ingredient) => ingredient.recipeId == recipe.id).toList();
    return recipeIngredients;
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    insertIngredients(recipe.ingredients);
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
    }
    return <int>[];
  }

  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    final id = recipe.id;
    if (id != null) {
      deleteRecipeIngredients(id);
    }
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients.removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }
}