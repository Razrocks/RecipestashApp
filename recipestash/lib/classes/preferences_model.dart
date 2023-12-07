// Import necessary packages and utilities for SQLite and preferences
import 'package:sqflite/sqflite.dart';
import 'package:recipestash/utilities/sqflite_utils.dart';
import 'package:recipestash/classes/preferences.dart';

// PreferencesModel class responsible for interacting with user preferences in SQFLite database
class PreferencesModel {
  // Method to check if preferences entry exists in the database
  Future<int> exists() async {
    // Initialize the SQFLite database using SqfliteUtils
    final Database db = await SqfliteUtils.init();

    // Query the 'preferences' table and check if the result is empty
    List<Map<String, dynamic>> result = await db.query('preferences');

    // Return 0 if no preferences entry found, otherwise return 1
    if (result.isEmpty) {
      return 0;
    } else {
      return 1;
    }
  }

  // Method to update existing preferences in the database
  Future<void> update(Preferences preferences) async {
    // Initialize the SQLite database using SqfliteUtils
    final Database db = await SqfliteUtils.init();

    // Update the 'preferences' table with the new preferences data
    await db.update(
      'preferences',
      preferences.toMap(),
      where: 'id = ?',
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to create a new preferences entry in the database
  Future<void> create(Preferences preferences) async {
    // Initialize the SQFLite database using SqfliteUtils
    final Database db = await SqfliteUtils.init();

    // Insert the new preferences data into the 'preferences' table
    await db.insert(
      'preferences',
      preferences.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to retrieve preferences from the database
  Future<Preferences> get() async {
    // Initialize the SQFLite database using SqfliteUtils
    final Database db = await SqfliteUtils.init();

    // Query the 'preferences' table and convert the result to a Preferences object
    List<Map<String, dynamic>> result = await db.query('preferences');
    return Preferences.fromMap(result[0]);
  }
}
