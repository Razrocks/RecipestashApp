import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RecipeForm extends StatefulWidget {
  final RecipeModel model;
  final bool isEdit;
  final Recipe? recipe;

  const RecipeForm({Key? key, required this.model, required this.isEdit, this.recipe}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm>
{
  final TextEditingController _titleController = TextEditingController();
  String? _category;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _imageUrl;
  final TextEditingController _servingSizeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _totalFatController = TextEditingController();
  final TextEditingController _saturatedFatController = TextEditingController();
  final TextEditingController _transFatController = TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _sodiumController = TextEditingController();
  final TextEditingController _totalCarbohydratesController = TextEditingController();
  final TextEditingController _dietaryFiberController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if (widget.isEdit == true) {
      _titleController.text = widget.recipe!.title;
      _category = widget.recipe!.category;
      _descriptionController.text = widget.recipe!.description;
      _prepTimeController.text = widget.recipe!.prepTime.toString();
      _cookTimeController.text = widget.recipe!.cookTime.toString();
      _servingsController.text = widget.recipe!.servings.toString();
      _ingredientsController.text = widget.recipe!.ingredients;
      _directionsController.text = widget.recipe!.directions;
      _notesController.text = widget.recipe!.notes;
      _imageUrl = widget.recipe!.imageUrl;
      _servingSizeController.text = widget.recipe!.servingSize.toString();
      _caloriesController.text = widget.recipe!.calories.toString();
      _totalFatController.text = widget.recipe!.totalFat.toString();
      _saturatedFatController.text = widget.recipe!.saturatedFat.toString();
      _transFatController.text = widget.recipe!.transFat.toString();
      _cholesterolController.text = widget.recipe!.cholesterol.toString();
      _sodiumController.text = widget.recipe!.sodium.toString();
      _totalCarbohydratesController.text = widget.recipe!.totalCarbohydrates.toString();
      _dietaryFiberController.text = widget.recipe!.dietaryFiber.toString();
      _sugarController.text = widget.recipe!.sugar.toString();
      _proteinController.text = widget.recipe!.protein.toString();
    }
  }

  void save(BuildContext context)
  {
    if (
      _titleController.text == '' ||
      _category == '' ||
      _descriptionController.text == '' ||
      _prepTimeController.text == '' ||
      _cookTimeController.text == '' ||
      _servingsController.text == '' ||
      _ingredientsController.text == '' ||
      _directionsController.text == '' ||
      _notesController.text == '' ||
      _imageUrl == '' ||
      _servingSizeController.text == '' ||
      _caloriesController.text == '' ||
      _totalFatController.text == '' ||
      _saturatedFatController.text == '' ||
      _transFatController.text == '' ||
      _cholesterolController.text == '' ||
      _sodiumController.text == '' ||
      _totalCarbohydratesController.text == '' ||
      _dietaryFiberController.text == '' ||
      _sugarController.text == '' ||
      _proteinController.text == ''
      ) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all required fields'),
      ));
    }
    
    if (widget.isEdit == true) {
      widget.model.updateRecipe(
        widget.recipe!.id!,
        _titleController.text,
        _category,
        _descriptionController.text,
        int.parse(_prepTimeController.text),
        int.parse(_cookTimeController.text),
        int.parse(_servingsController.text),
        _ingredientsController.text,
        _directionsController.text,
        _notesController.text,
        _imageUrl,
        double.parse(_servingSizeController.text),
        double.parse(_caloriesController.text),
        double.parse(_totalFatController.text),
        double.parse(_saturatedFatController.text),
        double.parse(_transFatController.text),
        double.parse(_cholesterolController.text),
        double.parse(_sodiumController.text),
        double.parse(_totalCarbohydratesController.text),
        double.parse(_dietaryFiberController.text),
        double.parse(_sugarController.text),
        double.parse(_proteinController.text)
      );
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      widget.model.addRecipe(
        _titleController.text,
        _category,
        _descriptionController.text,
        int.parse(_prepTimeController.text),
        int.parse(_cookTimeController.text),
        int.parse(_servingsController.text),
        _ingredientsController.text,
        _directionsController.text,
        _notesController.text,
        _imageUrl,
        double.parse(_servingSizeController.text),
        double.parse(_caloriesController.text),
        double.parse(_totalFatController.text),
        double.parse(_saturatedFatController.text),
        double.parse(_transFatController.text),
        double.parse(_cholesterolController.text),
        double.parse(_sodiumController.text),
        double.parse(_totalCarbohydratesController.text),
        double.parse(_dietaryFiberController.text),
        double.parse(_sugarController.text),
        double.parse(_proteinController.text)
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose()
  {
    _titleController.dispose();
    _descriptionController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _ingredientsController.dispose();
    _directionsController.dispose();
    _notesController.dispose();
    _servingSizeController.dispose();
    _caloriesController.dispose();
    _totalFatController.dispose();
    _saturatedFatController.dispose();
    _transFatController.dispose();
    _cholesterolController.dispose();
    _sodiumController.dispose();
    _totalCarbohydratesController.dispose();
    _dietaryFiberController.dispose();
    _sugarController.dispose();
    _proteinController.dispose();
    super.dispose();
  }

  Future<void> getImg() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().microsecondsSinceEpoch}.png');

      UploadTask uploadTask = storageRef.putFile(File(pickedImage.path));
      await uploadTask.whenComplete(() async {
        _imageUrl = await storageRef.getDownloadURL();
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? 'Edit Recipe' : 'Add Recipe')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _titleController, maxLength: 22),
            const Divider(),
            const Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButtonFormField(
              // value: _category,
              value: _category,
              items: const [
                DropdownMenuItem(value: 'Breakfast', child: Text('Breakfast')),
                DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                DropdownMenuItem(value: 'Dessert', child: Text('Dessert')),
                DropdownMenuItem(value: 'Snack', child: Text('Snack')),
                DropdownMenuItem(value: 'Drink', child: Text('Drink')),
              ], 
              onChanged: (value) {
                _category = value!;
              }),
            const Divider(),
            const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _descriptionController),
            const Divider(),
            const Text('Prep Time (minutes)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _prepTimeController, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number),
            const Divider(),
            const Text('Cook Time (minutes)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _cookTimeController, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number),
            const Divider(),
            const Text('Servings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _servingsController, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number),
            const Divider(),
            const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _ingredientsController, maxLines: 5),
            const Divider(),
            const Text('Directions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _directionsController, maxLines: 5),
            const Divider(),
            const Text('Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _notesController, maxLines: 5),
            const Divider(),
            const Text('Image URL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _imageUrl != null ? Image.network(_imageUrl!) : const Text('No image selected'),
            IconButton(
              onPressed: getImg,
              icon: const Icon(Icons.add_photo_alternate_outlined
              ),
            ),
            const Divider(),
            const Text('Serving Size (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _servingSizeController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Calories (kcal)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _caloriesController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Total Fat (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _totalFatController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Saturated Fat (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _saturatedFatController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Trans Fat (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _transFatController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Cholesterol (mg)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _cholesterolController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Sodium (mg)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _sodiumController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Total Carbohydrates (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _totalCarbohydratesController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Dietary Fiber (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _dietaryFiberController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Sugar (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _sugarController, keyboardType: TextInputType.number),
            const Divider(),
            const Text('Protein (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _proteinController, keyboardType: TextInputType.number),
            const Divider(),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {save(context);},
          child: widget.isEdit ? const Icon(Icons.save) : const Icon(Icons.add),
        ),
    );
  }
}