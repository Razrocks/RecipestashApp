import 'package:sqflite/sqflite.dart';
import 'package:recipestash/utilities/sqflite_utils.dart';
import 'package:recipestash/classes/preferences.dart';

class PreferencesModel {
  Future<int> exists() async {
    final Database db = await SqfliteUtils.init();

    List<Map<String, dynamic>> result = await db.query('preferences');

    if (result.isEmpty) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<void> update(Preferences preferences) async {
    final Database db = await SqfliteUtils.init();

    await db.update(
      'preferences',
      preferences.toMap(),
      where: 'id = ?',
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> create(Preferences  preferences) async {
    final Database db = await SqfliteUtils.init();

    await db.insert(
      'preferences',
      preferences.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Preferences> get() async {
    final Database db = await SqfliteUtils.init();

    List<Map<String, dynamic>> result = await db.query('preferences');
    return Preferences.fromMap(result[0]);
  }
}