import 'package:flutter/material.dart';
import 'package:recipestash/classes/recipe_model.dart';

class RecipeForm extends StatefulWidget {
  final RecipeModel model;
  final bool isEdit;
  final String? id;

  const RecipeForm({Key? key, required this.model, required this.isEdit, this.id}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm>
{
  String _category = '';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _directionsController = TextEditingController();
  final _notesController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _servingSizeController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _totalFatController = TextEditingController();
  final _saturatedFatController = TextEditingController();
  final _transFatController = TextEditingController();
  final _cholesterolController = TextEditingController();
  final _sodiumController = TextEditingController();
  final _totalCarbohydratesController = TextEditingController();
  final _dietaryFiberController = TextEditingController();
  final _sugarController = TextEditingController();
  final _proteinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
      widget.model.getRecipebyId(widget.id!).then((recipe){
        _titleController.text = recipe.title ?? '';
        _category = recipe.category ?? '';
        _descriptionController.text = recipe.description ?? '';
        _prepTimeController.text = recipe.prepTime.toString();
        _cookTimeController.text = recipe.cookTime.toString();
        _servingsController.text = recipe.servings.toString();
        _ingredientsController.text = recipe.ingredents ?? '';
        _directionsController.text = recipe.directions ?? '';
        _notesController.text = recipe.notes ?? '';
        _imageUrlController.text = recipe.imageUrl ?? '';
        _servingSizeController.text = recipe.servingSize.toString();
        _caloriesController.text = recipe.calories.toString();
        _totalFatController.text = recipe.totalfat.toString();
        _saturatedFatController.text = recipe.saturatedFat.toString();
        _transFatController.text = recipe.transFat.toString();
        _cholesterolController.text = recipe.cholesterol.toString();
        _sodiumController.text = recipe.sodium.toString();
        _totalCarbohydratesController.text = recipe.totalCarbohydrates.toString();
        _dietaryFiberController.text = recipe.dietaryFiber.toString();
        _sugarController.text = recipe.sugar.toString();
        _proteinController.text = recipe.protein.toString();
      });
    }
  }

  void save(BuildContext context)
  {
    if (_titleController.text == '' || _category == '' || _ingredientsController.text == '' || _directionsController.text == '')
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all required fields'),
      ));
    }
    
    if (widget.isEdit == true) {
      widget.model.updateRecipe(
        widget.id,
        _titleController.text,
        _category,
        _descriptionController.text,
        int.parse(_prepTimeController.text),
        int.parse(_cookTimeController.text),
        int.parse(_servingsController.text),
        _ingredientsController.text,
        _directionsController.text,
        _notesController.text,
        _imageUrlController.text,
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
        _imageUrlController.text,
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
    _imageUrlController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add/Edit Recipe')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _titleController),
            const Divider(),
            const Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButtonFormField(
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
            const Text('Prep Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _prepTimeController),
            const Divider(),
            const Text('Cook Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _cookTimeController),
            const Divider(),
            const Text('Servings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _servingsController),
            const Divider(),
            const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _ingredientsController),
            const Divider(),
            const Text('Directions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _directionsController),
            const Divider(),
            const Text('Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _notesController),
            const Divider(),
            const Text('Image URL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _imageUrlController),
            const Divider(),
            const Text('Serving Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _servingSizeController),
            const Divider(),
            const Text('Calories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _caloriesController),
            const Divider(),
            const Text('Total Fat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _totalFatController),
            const Divider(),
            const Text('Saturated Fat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _saturatedFatController),
            const Divider(),
            const Text('Trans Fat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _transFatController),
            const Divider(),
            const Text('Cholesterol', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _cholesterolController),
            const Divider(),
            const Text('Sodium', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _sodiumController),
            const Divider(),
            const Text('Total Carbohydrates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _totalCarbohydratesController),
            const Divider(),
            const Text('Dietary Fiber', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _dietaryFiberController),
            const Divider(),
            const Text('Sugar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _sugarController),
            const Divider(),
            const Text('Protein', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _proteinController),
            const Divider(),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {save(context);},
          child: const Icon(Icons.add),
        ),
    );
  }
}