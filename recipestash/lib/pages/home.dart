import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipestash/classes/preferences_model.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/main.dart';
import 'package:recipestash/pages/account.dart';
import 'package:recipestash/pages/recipe_overview.dart';
import 'package:recipestash/pages/recipe_form.dart';
import 'package:recipestash/pages/settings.dart';
import 'package:recipestash/pages/components/category_header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Authentication().currentUser;
  final RecipeModel _model = RecipeModel();
  List<Recipe> recipes = [];
  List<Recipe> displayedRecipes = [];
  String selectedCategory = ""; // Default category
  Color selectedThemeColor = Color.fromARGB(255, preferences.r!, preferences.g!,
      preferences.b!); // Default theme color
  TextEditingController searchController =
      TextEditingController(); // Controller for search field

  @override
  void initState() {
    super.initState();
    _model.getAllRecipes().listen((List<Recipe> allRecipes) {
      setState(() {
        recipes = allRecipes;
        displayedRecipes = recipes;
      });
    });
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  _filterRecipes(selectedCategory, query);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget card(String text, double w, double h, String imgUrl) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              // Stroked text as border.
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3)),
              // Solid text as fill.
              Text(text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
            ],
          ),
        ],
      ),
    );
  }

  Widget showRecipes(String selectedCategory, String searchQuery) {
    List<Recipe> filteredRecipes;

    if (searchQuery.isNotEmpty) {
      // Filter recipes based on search query
      filteredRecipes = recipes
          .where((recipe) =>
              recipe.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else if (selectedCategory != "All") {
      // Filter recipes based on selected category
      filteredRecipes = recipes
          .where((recipe) => recipe.category == selectedCategory)
          .toList();
    } else {
      // Display all recipes
      filteredRecipes = recipes;
    }

    return ListView.builder(
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeOverview(
                    recipe: filteredRecipes[index],
                    model: _model,
                  ),
                ),
              );
            },
            child: card(
              filteredRecipes[index].title,
              350,
              130,
              filteredRecipes[index].imageUrl,
            ),
          ),
        );
      },
    );
  }

  void addRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeForm(
          model: _model,
          isEdit: false,
        ),
      ),
    );
  }

  void navtoAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Account()),
    );
  }

  void navtoSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Settings()),
    ).then((value) {
      setState(() {
        selectedThemeColor =
            Color.fromARGB(255, preferences.r!, preferences.g!, preferences.b!);
      });
    });
  }

  Widget navBar(BuildContext context) {
    return BottomAppBar(
      height: 40,
      color: selectedThemeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home_outlined),
          IconButton(
            onPressed: () {
              navtoAccount(context);
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
          IconButton(
            onPressed: () {
              navtoSetting(context);
            },
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  void _filterRecipes(String category, String query) {
    // If the query is empty, reset to all recipes in the selected category
    if (query.isEmpty) {
      setState(() {
        selectedCategory = category;
        displayedRecipes = recipes;
      });
    } else {
      // If the category is not "All," switch to "All" category
      if (category != "All") {
        setState(() {
          selectedCategory = "All";
        });
      }

      // Filter recipes based on the selected category and search query
      setState(() {
        displayedRecipes = recipes
            .where((recipe) =>
                recipe.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            preferences.darkMode == 1 ? Colors.black : Colors.white,
        body: Column(
          children: [
            searchField(),
            CategoryHeader(
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                  _filterRecipes(selectedCategory, searchController.text);
                });
              },
            ),
            const Divider(),
            Expanded(
                child: showRecipes(selectedCategory, searchController.text)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addRecipe();
          },
          child: const Icon(Icons.add),
          backgroundColor: selectedThemeColor,
        ),
        bottomNavigationBar: navBar(context),
      ),
    );
  }
}
