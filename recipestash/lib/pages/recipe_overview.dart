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
        title: Text(widget.recipe.title ?? 'Recipe Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display recipe details here
            Text('Title: ${widget.recipe.title}'),
            Text('Category: ${widget.recipe.category}'),
            Text('Description: ${widget.recipe.description}'),
            Text('Prep Time: ${widget.recipe.prepTime}'),
            Text('Cook Time: ${widget.recipe.cookTime}'),
            Text('Servings: ${widget.recipe.servings}'),
            Text('Ingredients: ${widget.recipe.ingredents}'),
            Text('Directions: ${widget.recipe.directions}'),
            Text('Notes: ${widget.recipe.notes}'),
            Text('Image URL: ${widget.recipe.imageUrl}'),
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
    );
  }
}
