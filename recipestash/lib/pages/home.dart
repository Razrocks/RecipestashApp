// Import necessary packages and modules
import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/main.dart';
import 'package:recipestash/pages/account.dart';
import 'package:recipestash/pages/recipe_overview.dart';
import 'package:recipestash/pages/recipe_form.dart';
import 'package:recipestash/pages/settings.dart';

// Home class representing the Home screen in the Recipe app
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Initialize necessary objects and variables
  final User? user = Authentication().currentUser;
  final RecipeModel _model = RecipeModel();
  List<Recipe> recipes = [];
  List<Recipe> displayedRecipes = [];
  Color selectedThemeColor = Color.fromARGB(255, preferences.r!, preferences.g!,
      preferences.b!); // Default theme color
  TextEditingController searchController =
      TextEditingController(); // Controller for search field
  String searchQuery = ""; // Variable to store the search query
  String selectedCategory = ""; // Default category
  int selectedIndex = 0; // Default selected index
  List<String> categories = [
    "All",
    "Breakfast",
    "Lunch",
    "Dinner",
    "Dessert",
    "Snack",
    "Drink"
  ];

  // Initialize the state of the widget
  @override
  void initState() {
    super.initState();
    // Fetch all recipes from the database and update the state
    _model.getAllRecipes().listen((List<Recipe> allRecipes) {
      setState(() {
        recipes = allRecipes;
        displayedRecipes = recipes;
        selectedCategory = "All"; // Set the initial category
      });
    });
  }

  // Method to filter recipes based on the search query
  void _filterRecipes(String query) {
    setState(() {
      searchQuery = query;
      displayedRecipes = recipes
          .where((recipe) =>
              recipe.title.toLowerCase().contains(query.toLowerCase()) &&
              (recipe.category == selectedCategory ||
                  selectedCategory == "All"))
          .toList();
    });
  }

  // Method to handle category selection
  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      _filterRecipes(searchController.text);
    });
  }

  // Widget for the search field
  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Expanded(
          child: TextField(
            style: TextStyle(
                color: preferences.darkMode == 1
                    ? Colors.white
                    : Colors.black), // Set text color to white
            controller: searchController,
            onTap: () {
              // Set the selected category to "All" when the search bar is tapped
              onCategorySelected("All");
              selectedIndex = 0;
            },
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(
                      color: Colors.white) // Outline color when focused
                  ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(
                      color: Colors.white) // Outline color when unfocused
                  ),
              hintText: 'Search',
              suffixIcon: Icon(Icons.search,
                  color:
                      preferences.darkMode == 1 ? Colors.white : Colors.black),
            ),
            onChanged: (query) {
              setState(() {
                _filterRecipes(query);
                selectedIndex = 0;
              });
            },
          ),
        ),
      ]),
    );
  }

  // Widget for the recipe card
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
            Stack(children: [
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
            ]),
          ]),
    );
  }

  // Widget to display recipes
  Widget showRecipes() {
    List<Recipe> filteredRecipes;

    if (searchQuery.isNotEmpty) {
      // Filter recipes based on search query
      filteredRecipes = recipes
          .where((recipe) =>
              recipe.title.toLowerCase().contains(searchQuery.toLowerCase()) &&
              (recipe.category == selectedCategory ||
                  selectedCategory == "All"))
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
                      recipe: filteredRecipes[index], model: _model),
                ),
              );
            },
            child: card(filteredRecipes[index].title, 350, 130,
                filteredRecipes[index].imageUrl),
          ),
        );
      },
    );
  }

  // Method to navigate to the recipe form page for adding a new recipe
  void addRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeForm(model: _model, isEdit: false),
      ),
    );
  }

  // Method to navigate to the account page
  void navtoAccount(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Account()));
  }

  // Method to navigate to the settings page
  void navtoSetting(BuildContext context) {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Settings()))
        .then((value) {
      setState(() {
        selectedThemeColor =
            Color.fromARGB(255, preferences.r!, preferences.g!, preferences.b!);
      });
    });
  }

  // Widget for the bottom navigation bar
  Widget navBar(BuildContext context) {
    return BottomAppBar(
      height: 40,
      color: selectedThemeColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
          icon: const Icon(Icons.settings_outlined),
        )
      ]),
    );
  }

  // Build method to create the UI for the Home screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor:
              preferences.darkMode == 1 ? Colors.black : Colors.white,
          body: Column(children: [
            searchField(),
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  height: 25.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(index, categories)),
                ),
              ),
              const Divider(),
            ]),
            Expanded(child: showRecipes()),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addRecipe();
            },
            backgroundColor: selectedThemeColor,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: navBar(context)),
    );
  }

  // Widget to build a category item
  Widget buildCategoryItem(int index, List<String> categories) {
    return GestureDetector(
        onTap: () {
          setState(() {
            onCategorySelected(categories[index]);
            selectedIndex = index;
          });
        },
        child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: selectedIndex == index
                    ? const Color(0xFFEFF3EE)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16)),
            child: Text(categories[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index
                        ? Color.fromARGB(
                            255, preferences.r!, preferences.g!, preferences.b!)
                        : const Color(0xFFC2C2B5)))));
  }
}
