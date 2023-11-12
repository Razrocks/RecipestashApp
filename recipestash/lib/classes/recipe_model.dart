import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipestash/classes/authentication.dart';
import 'recipe.dart';

class RecipeModel {
  User? user;
  CollectionReference? db;

  RecipeModel() {
    user = Authentication().currentUser;
    db = FirebaseFirestore.instance.collection(user!.uid);
  }

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
    totalfat,
    saturatedFat,
    transFat,
    cholesterol,
    sodium,
    totalCarbohydrates,
    dietaryFiber,
    sugar,
    protein,
    ) async {
      Recipe data = Recipe(
        title: title,
        category: category,
        description: description,
        prepTime: prepTime,
        cookTime: cookTime,
        servings: servings,
        ingredents: ingredients,
        directions: directions,
        notes: notes,
        imageUrl: imageUrl,
        servingSize: servingSize,
        calories: calories,
        totalfat: totalfat,
        saturatedFat: saturatedFat,
        transFat: transFat,
        cholesterol: cholesterol,
        sodium: sodium,
        totalCarbohydrates: totalCarbohydrates,
        dietaryFiber: dietaryFiber,
        sugar: sugar,
        protein: protein,
      );
      DocumentReference? ref = await db?.add(data.toMap());
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
        totalfat,
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
    totalfat,
    saturatedFat,
    transFat,
    cholesterol,
    sodium,
    totalCarbohydrates,
    dietaryFiber,
    sugar,
    protein,
    ) async {
      DocumentReference ref = db!.doc(id);
      Recipe data = Recipe(
        id: id,
        title: title,
        category: category,
        description: description,
        prepTime: prepTime,
        cookTime: cookTime,
        servings: servings,
        ingredents: ingredients,
        directions: directions,
        notes: notes,
        imageUrl: imageUrl,
        servingSize: servingSize,
        calories: calories,
        totalfat: totalfat,
        saturatedFat: saturatedFat,
        transFat: transFat,
        cholesterol: cholesterol,
        sodium: sodium,
        totalCarbohydrates: totalCarbohydrates,
        dietaryFiber: dietaryFiber,
        sugar: sugar,
        protein: protein,
      );
      await ref.update(data.toMap());
    }

  Future<void> deleteRecipe(id) async {
    db?.doc(id).delete();
  }

  Stream<List<Recipe>> getAllRecipes() {
    return db!.snapshots().map((snapshot) => snapshot.docs.map((doc) {
      return Recipe.fromMap(doc.data() as Map<String, dynamic>, reference: doc.reference);
    }).toList());
  }

  Future<Recipe> getRecipebyId(String id) async {
    DocumentSnapshot documentSnapshot = await db!.doc(id).get();
    return Recipe.fromMap(documentSnapshot.data() as Map<String, dynamic>, reference: documentSnapshot.reference);
  }

  Future<void> deleteAllRecipe() async {
    QuerySnapshot querySnapshot = await db!.get();
    for (QueryDocumentSnapshot element in querySnapshot.docs) { 
      element.reference.delete();}
  }
}
