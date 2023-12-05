import 'package:flutter/material.dart';
import 'package:recipestash/classes/recipe.dart';

class RecipeOverview extends StatefulWidget {
  final Recipe recipe;

  const RecipeOverview({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeOverviewState createState() => _RecipeOverviewState();
}

class _RecipeOverviewState extends State<RecipeOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Recipe Overview',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              _buildSectionTitle('Overview'),
              _buildRecipeDetail('Title', widget.recipe.title),
              _buildRecipeDetail('Category', widget.recipe.category),
              Text('Description: ${widget.recipe.description}'),
              Text('Prep Time: ${widget.recipe.prepTime}'),
              Text('Cook Time: ${widget.recipe.cookTime}'),
              Text('Servings: ${widget.recipe.servings}'),

              // Ingredients Section
              _buildSectionTitle('Ingredients'),
              Text('Ingredients: ${widget.recipe.ingredents}'),

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
              Text('Total Fat: ${widget.recipe.totalfat}'),
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
