import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'package:fooderlich/screens/grocery_screen.dart';
import 'package:fooderlich/screens/recipes_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  static MaterialPage page(int currentTab) {
    return MaterialPage(
        name: FooderlichPages.home,
        key: ValueKey(FooderlichPages.home),
        child: Home(
          currentTab: currentTab,
        )
    );
  }

  const Home({super.key, required this.currentTab});

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    GroceryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (context, appStateManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            profileButton(),
          ],
        ),
        body: IndexedStack(index: widget.currentTab, children: pages,),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: widget.currentTab,
          onTap: (index) {
            Provider.of<AppStateManager>(context, listen: false).goToTab(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book), label: 'Recipes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'To Buy'),
          ],
        ),
      );
    });
  }

  Widget profileButton() {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/profile_pics/person_stef.jpeg'),
        ),
        onTap: () {
          Provider.of<ProfileManager>(context, listen: false).tapOnProfile(true);
        },
      ),
    );
  }

}
