import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipestash/classes/recipe.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipestash/main.dart';

class RecipeForm extends StatefulWidget {
  final RecipeModel model;
  final bool isEdit;
  final Recipe? recipe;

  const RecipeForm(
      {Key? key, required this.model, required this.isEdit, this.recipe})
      : super(key: key);

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
      backgroundColor: preferences.darkMode == 1 ? Colors.black : Colors.white,
      appBar: AppBar(title: Text(widget.isEdit ? 'Edit Recipe' : 'Add Recipe', style: const TextStyle(color: Colors.black)), backgroundColor: Color.fromARGB( 255,preferences.r!, preferences.g!, preferences.b!),
      iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _titleController, maxLength: 22,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            DropdownButtonFormField(
            value: _category,
            items:  [
              DropdownMenuItem(value: 'Breakfast', child: Text('Breakfast', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black))),
              DropdownMenuItem(value: 'Lunch', child: Text('Lunch', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black))),
              DropdownMenuItem(value: 'Dinner', child: Text('Dinner', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black))),
              DropdownMenuItem(value: 'Dessert', child: Text('Dessert', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black))),
              DropdownMenuItem(value: 'Snack', child: Text('Snack', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black))),
              DropdownMenuItem(value: 'Drink', child: Text('Drink', style: TextStyle(color:preferences.darkMode == 1 ? Colors.white : Colors.black))),
            ],
            onChanged: (value) {
              setState(() {
            _category = value!;
              });
            },
            style: const TextStyle(color: Colors.white), // Set the color of the selected value
            dropdownColor: preferences.darkMode == 1 ? Colors.black : Colors.white, // Set the dropdown background color
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black),
               ),
              focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black),
                ),
              ),
            ),

            const Divider(),
            Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(
                 controller: _descriptionController,
                  style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),

            const Divider(),
            Text('Prep Time (minutes)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _prepTimeController, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ), 
            ),
          
            const Divider(),
            Text('Cook Time (minutes)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _cookTimeController, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Servings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _servingsController, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _ingredientsController, maxLines: 5,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
              ),
            const Divider(),
            Text('Directions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _directionsController, maxLines: 5,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _notesController, maxLines: 5,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Image URL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            _imageUrl != null ? Image.network(_imageUrl!) : const Text('No image selected'),
            IconButton(
              onPressed: getImg,
              icon: Icon(Icons.add_photo_alternate_outlined, color: preferences.darkMode == 1 ? Colors.white : Colors.black,
              ),
            ),
            const Divider(),
            Text('Serving Size (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _servingSizeController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Calories (kcal)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _caloriesController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),
            ),
            const Divider(),
            Text('Total Fat (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _totalFatController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))],  keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Saturated Fat (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _saturatedFatController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Trans Fat (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _transFatController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Cholesterol (mg)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _cholesterolController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Sodium (mg)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _sodiumController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Total Carbohydrates (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _totalCarbohydratesController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Dietary Fiber (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _dietaryFiberController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Sugar (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _sugarController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
            
            
            
             ),
            const Divider(),
            Text('Protein (g)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            TextField(controller: _proteinController, inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r','))], keyboardType: TextInputType.number,
            style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set text color to white
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set underline color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: preferences.darkMode == 1 ? Colors.white : Colors.black), // Set focused underline color to white
                  ),
              ),  
             ),
            const Divider(),
            ],
          )
        )
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {save(context);},
          backgroundColor: Color.fromARGB( 255,preferences.r!, preferences.g!, preferences.b!),
          child: widget.isEdit ? const Icon(Icons.save) : const Icon(Icons.add),
        ),
    );
  }
}