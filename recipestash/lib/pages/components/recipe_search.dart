import 'package:flutter/material.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/pages/recipe_overview.dart';

class RecipeSearch extends SearchDelegate<String> {
  final RecipeModel model;

  RecipeSearch({required this.model});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform search and display matching recipes
    return showRecipes(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display suggestions based on user input
    return Container();
  }

  Widget showRecipes(String query) {
    return StreamBuilder(
      stream: model.getAllRecipes(), // Change to a search stream if available
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Recipe>? recipes = snapshot.data;
          List<Recipe> filteredRecipes = recipes!
              .where((recipe) =>
                  recipe.title.toLowerCase().contains(query.toLowerCase()))
              .toList();

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
                          model: model,
                        ),
                      ),
                    );
                  },
                  child: card(filteredRecipes[index].title, 350, 130),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget card(String text, double w, double h) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
            child: Center(child: Text(text)),
          ),
        ],
      ),
    );
  }
}
