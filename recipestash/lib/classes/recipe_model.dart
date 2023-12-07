// Import necessary packages and classes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipestash/classes/authentication.dart';
import 'recipe.dart';

// RecipeModel class responsible for interacting with recipes in Firestore
class RecipeModel {
  // User and Firestore collection references
  User? user;
  CollectionReference? db;

  // Constructor initializes user and Firestore collection references
  RecipeModel() {
    user = Authentication().currentUser;
    db = FirebaseFirestore.instance.collection(user!.uid);
  }

  // Method to add a new recipe to the Firestore collection
  Future<void> addRecipe(
    title,
    category,
    description,
    prepTime,
    cookTime,
    servings,
    ingredients,
    directions,
    notes,
    imageUrl,
    servingSize,
    calories,
    totalFat,
    saturatedFat,
    transFat,
    cholesterol,
    sodium,
    totalCarbohydrates,
    dietaryFiber,
    sugar,
    protein,
  ) async {
    // Create a Recipe object from the provided data
    Recipe data = Recipe(
      title: title,
      category: category,
      description: description,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      ingredients: ingredients,
      directions: directions,
      notes: notes,
      imageUrl: imageUrl,
      servingSize: servingSize,
      calories: calories,
      totalFat: totalFat,
      saturatedFat: saturatedFat,
      transFat: transFat,
      cholesterol: cholesterol,
      sodium: sodium,
      totalCarbohydrates: totalCarbohydrates,
      dietaryFiber: dietaryFiber,
      sugar: sugar,
      protein: protein,
    );

    // Add the recipe to the Firestore collection
    DocumentReference? ref = await db?.add(data.toMap());

    // Update the recipe with the assigned document reference
    updateRecipe(
      ref?.id,
      title,
      category,
      description,
      prepTime,
      cookTime,
      servings,
      ingredients,
      directions,
      notes,
      imageUrl,
      servingSize,
      calories,
      totalFat,
      saturatedFat,
      transFat,
      cholesterol,
      sodium,
      totalCarbohydrates,
      dietaryFiber,
      sugar,
      protein,
    );
  }

  // Method to update an existing recipe in the Firestore collection
  Future<void> updateRecipe(
    id,
    title,
    category,
    description,
    prepTime,
    cookTime,
    servings,
    ingredients,
    directions,
    notes,
    imageUrl,
    servingSize,
    calories,
    totalFat,
    saturatedFat,
    transFat,
    cholesterol,
    sodium,
    totalCarbohydrates,
    dietaryFiber,
    sugar,
    protein,
  ) async {
    // Obtain the document reference for the specified recipe
    DocumentReference ref = db!.doc(id);

    // Create a Recipe object with the updated data
    Recipe data = Recipe(
      id: id,
      title: title,
      category: category,
      description: description,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      ingredients: ingredients,
      directions: directions,
      notes: notes,
      imageUrl: imageUrl,
      servingSize: servingSize,
      calories: calories,
      totalFat: totalFat,
      saturatedFat: saturatedFat,
      transFat: transFat,
      cholesterol: cholesterol,
      sodium: sodium,
      totalCarbohydrates: totalCarbohydrates,
      dietaryFiber: dietaryFiber,
      sugar: sugar,
      protein: protein,
    );

    // Update the recipe in the Firestore collection
    await ref.update(data.toMap());
  }

  // Method to delete a recipe from the Firestore collection
  Future<void> deleteRecipe(id) async {
    db?.doc(id).delete();
  }

  // Stream to get a real-time list of all recipes from the Firestore collection
  Stream<List<Recipe>> getAllRecipes() {
    return db!.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          return Recipe.fromMap(doc.data() as Map<String, dynamic>,
              reference: doc.reference);
        }).toList());
  }

  // Method to get a specific recipe by its ID from the Firestore collection
  Future<Recipe> getRecipebyId(String id) async {
    DocumentSnapshot documentSnapshot = await db!.doc(id).get();
    return Recipe.fromMap(documentSnapshot.data() as Map<String, dynamic>,
        reference: documentSnapshot.reference);
  }

  // Method to delete all recipes from the Firestore collection
  Future<void> deleteAllRecipe() async {
    QuerySnapshot querySnapshot = await db!.get();
    for (QueryDocumentSnapshot element in querySnapshot.docs) {
      element.reference.delete();
    }
  }

  // Stream to get a real-time list of recipes filtered by category from the Firestore collection
  Stream<List<Recipe>> getRecipesByCategory(String category) {
    // Check if the category is null or empty, then return all recipes
    if (category.isEmpty) {
      return getAllRecipes();
    } else {
      // Filter recipes by category and return a real-time stream
      return db!
          .where('category', isEqualTo: category)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return Recipe.fromMap(doc.data() as Map<String, dynamic>,
                    reference: doc.reference);
              }).toList());
    }
  }

  // Stream to get a real-time list of recipes based on category and search query from the Firestore collection
  Stream<List<Recipe>> searchRecipes(String category, String query) {
    // Create a Firestore query based on the selected category and search query
    Query queryRef = db!.where('category', isEqualTo: category);

    // If the query is not empty, add a filter for the title
    if (query.isNotEmpty) {
      queryRef = queryRef.where('title', isGreaterThanOrEqualTo: query);
    }

    // Return a real-time stream of filtered recipes
    return queryRef.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          return Recipe.fromMap(doc.data() as Map<String, dynamic>,
              reference: doc.reference);
        }).toList());
  }
}
