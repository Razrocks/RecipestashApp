import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  //overview tab
  String? id;
  String? title; //mandatory
  String? category; //mandatory
  String? description; 
  int? prepTime; //in minutes
  int? cookTime; //in minutes
  int? servings; //in number
  
  //ingredients tab
  String? ingredients; //mandatory

  //directions tab
  String? directions; //mandatory

  //other tab
  String? notes;
  String? imageUrl; //uploaded image url

  //nutrition tab
  double? servingSize; //in g
  double? calories; //in kcal
  double? totalFat; //in g
  double? saturatedFat; //in g
  double? transFat; //in g
  double? cholesterol; //in mg
  double? sodium; //in mg
  double? totalCarbohydrates; //in g
  double? dietaryFiber; //in g
  double? sugar; //in g
  double? protein; //in g
  DocumentReference? reference;

  Recipe({
    this.id,
    required this.title,
    required this.category,
    this.description,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.ingredients,
    this.directions,
    this.notes,
    this.imageUrl,
    this.servingSize,
    this.calories,
    this.totalFat,
    this.saturatedFat,
    this.transFat,
    this.cholesterol,
    this.sodium,
    this.totalCarbohydrates,
    this.dietaryFiber,
    this.sugar,
    this.protein,
  });

  Map<String, dynamic> toMap()
  {
    return {
      'id' : id,
      'title' : title,
      'category' : category,
      'description' : description,
      'prepTime' : prepTime,
      'cookTime' : cookTime,
      'servings' : servings,
      'ingredients' : ingredients,
      'directions' : directions,
      'notes' : notes,
      'imageUrl' : imageUrl,
      'servingSize' : servingSize,
      'calories' : calories,
      'totalFat' : totalFat,
      'saturatedFat' : saturatedFat,
      'transFat' : transFat,
      'cholesterol' : cholesterol,
      'sodium' : sodium,
      'totalCarbohydrates' : totalCarbohydrates,
      'dietaryFiber' : dietaryFiber,
      'sugar' : sugar,
      'protein' : protein,
    };
  }

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

  @override
  String toString() {
    return '''
      Recipe:
        Title: $title
        Category: $category
        Description: $description
        Prep Time: ${prepTime ?? 'N/A'} minutes
        Cook Time: ${cookTime ?? 'N/A'} minutes
        Servings: ${servings ?? 'N/A'}

        Ingredients:
            $ingredients

        Directions:
            $directions

        Other:
            Notes: $notes

        Nutrition:
            Serving Size: ${servingSize ?? 'N/A'} g
            Calories: ${calories ?? 'N/A'} kcal
            Total Fat: ${totalFat ?? 'N/A'} g
            Saturated Fat: ${saturatedFat ?? 'N/A'} g
            Trans Fat: ${transFat ?? 'N/A'} g
            Cholesterol: ${cholesterol ?? 'N/A'} mg
            Sodium: ${sodium ?? 'N/A'} mg
            Total Carbohydrates: ${totalCarbohydrates ?? 'N/A'} g
            Dietary Fiber: ${dietaryFiber ?? 'N/A'} g
            Sugar: ${sugar ?? 'N/A'} g
            Protein: ${protein ?? 'N/A'} g
    ''';
  }

    String toHtmlString() {
    return '''
      <html>
      <head>
        <title>${title ?? 'Untitled Recipe'}</title>
      </head>
      <body>
        <h1>${title ?? 'Untitled Recipe'}</h1>
        <h2>Category: ${category ?? 'N/A'}</h2>
        <p>Description: ${description ?? 'N/A'}</p>
        <p>Prep Time: ${prepTime ?? 'N/A'} minutes</p>
        <p>Cook Time: ${cookTime ?? 'N/A'} minutes</p>
        <p>Servings: ${servings ?? 'N/A'}</p>

        <h2>Ingredients:</h2>
        <p>${ingredients ?? 'N/A'}</p>

        <h2>Directions:</h2>
        <p>${directions ?? 'N/A'}</p>

        <h2>Other:</h2>
        <p>Notes: ${notes ?? 'N/A'}</p>

        <h2>Nutrition:</h2>
        <p>Serving Size: ${servingSize ?? 'N/A'} g</p>
        <p>Calories: ${calories ?? 'N/A'} kcal</p>
        <p>Total Fat: ${totalFat ?? 'N/A'} g</p>
        <p>Saturated Fat: ${saturatedFat ?? 'N/A'} g</p>
        <p>Trans Fat: ${transFat ?? 'N/A'} g</p>
        <p>Cholesterol: ${cholesterol ?? 'N/A'} mg</p>
        <p>Sodium: ${sodium ?? 'N/A'} mg</p>
        <p>Total Carbohydrates: ${totalCarbohydrates ?? 'N/A'} g</p>
        <p>Dietary Fiber: ${dietaryFiber ?? 'N/A'} g</p>
        <p>Sugar: ${sugar ?? 'N/A'} g</p>
        <p>Protein: ${protein ?? 'N/A'} g</p>
      </body>
      </html>
    ''';
  }
}