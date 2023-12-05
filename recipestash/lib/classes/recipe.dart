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
  String? ingredents; //mandatory

  //directions tab
  String? directions; //mandatory

  //other tab
  String? notes;
  String? imageUrl; //uploaded image url

  //nutrition tab
  double? servingSize; //in g
  double? calories; //in kcal
  double? totalfat; //in g
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
    this.ingredents,
    this.directions,
    this.notes,
    this.imageUrl,
    this.servingSize,
    this.calories,
    this.totalfat,
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
      'ingredents' : ingredents,
      'directions' : directions,
      'notes' : notes,
      'imageUrl' : imageUrl,
      'servingSize' : servingSize,
      'calories' : calories,
      'totalfat' : totalfat,
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
    ingredents = map['ingredents'];
    directions = map['directions'];
    notes = map['notes'];
    imageUrl = map['imageUrl'];
    servingSize = map['servingSize'];
    calories = map['calories'];
    totalfat = map['totalfat'];
    saturatedFat = map['saturatedFat'];
    transFat = map['transFat'];
    cholesterol = map['cholesterol'];
    sodium = map['sodium'];
    totalCarbohydrates = map['totalCarbohydrates'];
    dietaryFiber = map['dietaryFiber'];
    sugar = map['sugar'];
    protein = map['protein'];
  }
}