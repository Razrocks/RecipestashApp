import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/pages/account.dart';
import 'package:recipestash/pages/recipe_overview.dart';
import 'package:recipestash/pages/recipe_form.dart';
import 'package:recipestash/pages/settings.dart';
import 'package:recipestash/pages/components/category_header.dart';
import 'package:recipestash/pages/components/recipe_search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Authentication().currentUser;
  final RecipeModel _model = RecipeModel();
  List<Recipe> recipes = [];
  String selectedCategory = "Breakfast"; // Default category

  @override
  void initState() {
    super.initState();
    recipes = [];
  }

  Widget searchField() {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              onTap: () {
                showSearch(
                  context: context,
                  delegate: RecipeSearch(model: _model),
                );
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
      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              // Stroked text as border.
              Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 3)),
              // Solid text as fill.
              Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
            ],
          ),
        ],
      ),
    );
  }

  Widget showRecipes(String selectedCategory) {
    return StreamBuilder(
      stream: _model.getRecipesByCategory(selectedCategory),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeOverview(
                          recipe: recipes[index],
                          model: _model,
                        ),
                      ),
                    );
                  },
                  child: card(recipes[index].title, 350, 130, recipes[index].imageUrl),
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
    );
  }

  Widget navBar(BuildContext context) {
    return BottomAppBar(
      height: 40,
      color: Colors.grey,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            searchField(),
            CategoryHeader(
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            const Divider(),
            Expanded(child: showRecipes(selectedCategory)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addRecipe();
          },
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: navBar(context),
      ),
    );
  }
}