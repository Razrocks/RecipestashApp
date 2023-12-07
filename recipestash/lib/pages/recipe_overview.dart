import 'package:flutter/material.dart';
import 'package:recipestash/classes/preferences.dart';
import 'package:recipestash/classes/preferences_model.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/pages/recipe_form.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:printing/printing.dart';
import 'package:recipestash/main.dart';
import 'package:recipestash/pages/settings.dart';
import 'package:recipestash/pages/home.dart';

void main() async {
  await initializePreferences();
}

Future<void> initializePreferences() async {
  Preferences preferences = await PreferencesModel().get();
}

class RecipeOverview extends StatefulWidget {
  final Recipe recipe;
  final RecipeModel model;

  const RecipeOverview({Key? key, required this.recipe, required this.model}) : super(key: key);

  @override
  State<RecipeOverview> createState() => _RecipeOverviewState();
}

class _RecipeOverviewState extends State<RecipeOverview> {
  void moreMenu() {
    showMenu(
      context: context, 
      position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width, -MediaQuery.of(context).size.height, 0, 0),
      items: [
        PopupMenuItem(
          child: const Text('Edit'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipeForm(model: widget.model, isEdit: true, recipe: widget.recipe))
            );
          }
        ),
        PopupMenuItem(
          child: const Text('Share'),
          onTap: () {
            FlutterShare.share(title: "Recipe Share", text: widget.recipe.toString());
          }
        ), 
        PopupMenuItem(
          child: const Text('Print'),
          onTap: () {
            printPDF();
          }
        ),
        PopupMenuItem(
          child: const Text('Delete'),
          onTap: () {
            widget.model.deleteRecipe(widget.recipe.id);
            Navigator.pop(context);
          }
        )
      ]);
  }

  void printPDF() {
    Printing.layoutPdf(
      onLayout: (format) async => await Printing.convertHtml(
        format: format,
        html: widget.recipe.toHtmlString()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: preferences.darkMode == 1 ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:  Color.fromARGB( 255,preferences.r!, preferences.g!, preferences.b!),
        title: Text(
          'Recipe Overview',
          style: TextStyle(
            color: preferences.darkMode == 1 ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_sharp),
            onPressed: moreMenu
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              Image(image: NetworkImage(widget.recipe.imageUrl)),
              _buildSectionTitle('Overview'),
              _buildRecipeDetail('Title', widget.recipe.title),
              _buildRecipeDetail('Category', widget.recipe.category),
              Text('Description: ${widget.recipe.description}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Prep Time: ${widget.recipe.prepTime}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Cook Time: ${widget.recipe.cookTime}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Servings: ${widget.recipe.servings}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),

              // Ingredients Section
              _buildSectionTitle('Ingredients'),
              Text('Ingredients: ${widget.recipe.ingredients}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),

              // Directions Section
              _buildSectionTitle('Directions'),
              Text('Directions: ${widget.recipe.directions}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),

              // Miscellaneous Section
              _buildSectionTitle('Miscellaneous'),
              Text('Notes: ${widget.recipe.notes}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Image URL: ${widget.recipe.imageUrl}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),

              // Nutrition Section
              _buildSectionTitle('Nutrition'),
              Text('Serving Size: ${widget.recipe.servingSize}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Calories: ${widget.recipe.calories}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Total Fat: ${widget.recipe.totalFat}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Saturated Fat: ${widget.recipe.saturatedFat}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Saturated Fat: ${widget.recipe.transFat}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Cholesterol: ${widget.recipe.cholesterol}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Sodium: ${widget.recipe.sodium}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Total Carbohydrates: ${widget.recipe.totalCarbohydrates}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Dietary Fiber: ${widget.recipe.dietaryFiber}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Sugar: ${widget.recipe.sugar}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
              Text('Protein: ${widget.recipe.protein}', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black),),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color:  preferences.darkMode == 1 ? Colors.white : Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecipeDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: preferences.darkMode == 1 ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? '-',
            style: TextStyle(
              color: preferences.darkMode == 1 ? Colors.white : Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
