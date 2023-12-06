import 'package:flutter/material.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/pages/recipe_form.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:printing/printing.dart';

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
      appBar: AppBar(
        title: const Text(
          'Recipe Overview',
          style: TextStyle(
            color: Colors.black,
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
              Text('Description: ${widget.recipe.description}'),
              Text('Prep Time: ${widget.recipe.prepTime}'),
              Text('Cook Time: ${widget.recipe.cookTime}'),
              Text('Servings: ${widget.recipe.servings}'),

              // Ingredients Section
              _buildSectionTitle('Ingredients'),
              Text('Ingredients: ${widget.recipe.ingredients}'),

              // Directions Section
              _buildSectionTitle('Directions'),
              Text('Directions: ${widget.recipe.directions}'),

              // Miscellaneous Section
              _buildSectionTitle('Miscellaneous'),
              Text('Notes: ${widget.recipe.notes}'),
              Text('Image URL: ${widget.recipe.imageUrl}'),

              // Nutrition Section
              _buildSectionTitle('Nutrition'),
              Text('Serving Size: ${widget.recipe.servingSize}'),
              Text('Calories: ${widget.recipe.calories}'),
              Text('Total Fat: ${widget.recipe.totalFat}'),
              Text('Saturated Fat: ${widget.recipe.saturatedFat}'),
              Text('Saturated Fat: ${widget.recipe.transFat}'),
              Text('Cholesterol: ${widget.recipe.cholesterol}'),
              Text('Sodium: ${widget.recipe.sodium}'),
              Text('Total Carbohydrates: ${widget.recipe.totalCarbohydrates}'),
              Text('Dietary Fiber: ${widget.recipe.dietaryFiber}'),
              Text('Sugar: ${widget.recipe.sugar}'),
              Text('Protein: ${widget.recipe.protein}'),
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
        style: const TextStyle(
          color: Colors.black,
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
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? '-',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
