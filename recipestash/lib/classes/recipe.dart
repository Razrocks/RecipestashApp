// recipe.dart

// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';

// Recipe class representing a recipe in the Recipe app
class Recipe {
  // Overview tab attributes
  String? id;
  late String title;
  late String category;
  late String description;
  late int prepTime; // in minutes
  late int cookTime; // in minutes
  late int servings; // in number

  // Ingredients tab attribute
  late String ingredients;

  // Directions tab attribute
  late String directions;

  // Other tab attributes
  late String notes;
  late String imageUrl; // uploaded image URL

  // Nutrition tab attributes
  late double servingSize; // in g
  late double calories; // in kcal
  late double totalFat; // in g
  late double saturatedFat; // in g
  late double transFat; // in g
  late double cholesterol; // in mg
  late double sodium; // in mg
  late double totalCarbohydrates; // in g
  late double dietaryFiber; // in g
  late double sugar; // in g
  late double protein; // in g
  DocumentReference? reference;

  // Constructor for creating a Recipe object with optional parameters
  Recipe({
    this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.ingredients,
    required this.directions,
    required this.notes,
    required this.imageUrl,
    required this.servingSize,
    required this.calories,
    required this.totalFat,
    required this.saturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.sodium,
    required this.totalCarbohydrates,
    required this.dietaryFiber,
    required this.sugar,
    required this.protein,
  });

  // Method to convert Recipe object to a map of key-value pairs
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'ingredients': ingredients,
      'directions': directions,
      'notes': notes,
      'imageUrl': imageUrl,
      'servingSize': servingSize,
      'calories': calories,
      'totalFat': totalFat,
      'saturatedFat': saturatedFat,
      'transFat': transFat,
      'cholesterol': cholesterol,
      'sodium': sodium,
      'totalCarbohydrates': totalCarbohydrates,
      'dietaryFiber': dietaryFiber,
      'sugar': sugar,
      'protein': protein,
    };
  }

  // Constructor to create a Recipe object from a map of key-value pairs
  Recipe.fromMap(Map<String, dynamic> map, {required this.reference}) {
    id = reference?.id;
    title = map['title'];
    category = map['category'];
    description = map['description'];
    prepTime = map['prepTime'];
    cookTime = map['cookTime'];
    servings = map['servings'];
    ingredients = map['ingredients'];
    directions = map['directions'];
    notes = map['notes'];
    imageUrl = map['imageUrl'];
    servingSize = map['servingSize'];
    calories = map['calories'];
    totalFat = map['totalFat'];
    saturatedFat = map['saturatedFat'];
    transFat = map['transFat'];
    cholesterol = map['cholesterol'];
    sodium = map['sodium'];
    totalCarbohydrates = map['totalCarbohydrates'];
    dietaryFiber = map['dietaryFiber'];
    sugar = map['sugar'];
    protein = map['protein'];
  }

  // Override toString method to provide a formatted string representation of Recipe object
  @override
  String toString() {
    return '''
      Recipe:
        Title: $title
        Category: $category
        Description: $description
        Prep Time: $prepTime minutes
        Cook Time: $cookTime minutes
        Servings: $servings

        Ingredients:
            $ingredients

        Directions:
            $directions

        Other:
            Notes: $notes

        Nutrition:
            Serving Size: $servingSize g
            Calories: $calories kcal
            Total Fat: $totalFat g
            Saturated Fat: $saturatedFat g
            Trans Fat: $transFat g
            Cholesterol: $cholesterol mg
            Sodium: $sodium mg
            Total Carbohydrates: $totalCarbohydrates g
            Dietary Fiber: $dietaryFiber g
            Sugar: $sugar g
            Protein: $protein g
    ''';
  }

  // Method to convert Recipe object to an HTML-formatted string
  String toHtmlString() {
    return '''
      <html>
      <head>
        <title>$title</title>
      </head>
      <body>
        <h1>$title</h1>
        <h2>Category: $category</h2>
        <p>Description: $description</p>
        <p>Prep Time: $prepTime minutes</p>
        <p>Cook Time: $cookTime minutes</p>
        <p>Servings: $servings</p>

        <h2>Ingredients:</h2>
        <p>$ingredients</p>

        <h2>Directions:</h2>
        <p>$directions</p>

        <h2>Other:</h2>
        <p>Notes: $notes</p>

        <h2>Nutrition:</h2>
        <p>Serving Size: $servingSize g</p>
        <p>Calories: $calories kcal</p>
        <p>Total Fat: $totalFat g</p>
        <p>Saturated Fat: $saturatedFat g</p>
        <p>Trans Fat: $transFat g</p>
        <p>Cholesterol: $cholesterol mg</p>
        <p>Sodium: $sodium mg</p>
        <p>Total Carbohydrates: $totalCarbohydrates g</p>
        <p>Dietary Fiber: $dietaryFiber g</p>
        <p>Sugar: $sugar g</p>
        <p>Protein: $protein g</p>
      </body>
      </html>
    ''';
  }
}
