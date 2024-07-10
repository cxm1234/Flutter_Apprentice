import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_finder/colors.dart';
import 'package:recipe_finder/network/recipe_model.dart';
import 'package:recipe_finder/ui/recipe_card.dart';
import 'package:recipe_finder/ui/recipes/recipe_details.dart';
import 'package:recipe_finder/ui/widgets/custom_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeList extends StatefulWidget {

  const RecipeList({super.key});

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;

  List<String> previousSearches = <String>[];

  APIRecipeQuery? _currentRecipes1;

  @override
  void initState() {
    super.initState();
    loadRecipes();
    getPreviousSearches();
    searchTextController = TextEditingController(text: '');
    _scrollController
      .addListener(() {
        final triggerFetchMoreSize = 0.7 * _scrollController.position.maxScrollExtent;
        if (_scrollController.position.pixels > triggerFetchMoreSize) {
          if (hasMore && currentEndPosition < currentCount && !loading && !inErrorState) {
            setState(() {
              loading = true;
              currentStartPosition = currentEndPosition;
              currentEndPosition = min(currentStartPosition + pageCount, currentCount);
            });
          }
        }
      });
  }

  Future loadRecipes() async {
    final jsonString = await rootBundle.loadString('assets/recipes1.json');
    setState(() {
      _currentRecipes1 = APIRecipeQuery.fromJSON(jsonDecode(jsonString));
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      previousSearches = prefs.getStringList(prefSearchKey) ?? <String>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildRecipeLoader(context)
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search'
                ),
                autofocus: false,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  if (!previousSearches.contains(value)) {
                    previousSearches.add(value);
                    savePreviousSearches();
                  }
                },
                controller: searchTextController,
              ),
            ),
            PopupMenuButton(
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: lightGrey,
                ),
                onSelected: (String value) {
                  searchTextController.text = value;
                  startSearch(searchTextController.text);
                },
                itemBuilder: (BuildContext context) {
                  return previousSearches.map<CustomDropdownMenuItem<String>>((String value) {
                    return CustomDropdownMenuItem<String>(
                      text: value,
                      value: value,
                      callback: () {
                        setState(() {
                          previousSearches.remove(value);
                          Navigator.pop(context);
                        });
                      },
                    );
                  }).toList();
                }
            )
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Widget _buildRecipeLoader(BuildContext context) {
    final hits = _currentRecipes1?.hits;
    if (_currentRecipes1 == null || hits == null) {
      return Container();
    }
    return Center(
      child: _buildRecipeCard(context, hits, 0),
    );
  }

  Widget _buildRecipeCard(BuildContext context, List<APIHits> hits, int index) {
    final recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RecipeDetails();
        }));
      },
      child: recipeStringCard(recipe.image, recipe.label),
    );
  }

}