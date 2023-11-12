import 'package:sqflite/sqflite.dart';
import 'package:recipestash/sqflite_utils.dart';
import 'package:recipestash/classes/preferences.dart';

class PreferencesModel {
  Future<void> update(Preferences preferences) async {
    final Database db = await SqfliteUtils.init();

    List<Map<String, dynamic>> result = await db.query('preferences');
    if (result.isNotEmpty) {
      await db.update(
        'preferences',
        preferences.toMap(),
        where: 'id = ?',
        whereArgs: [1],
      );
    } else {
      await db.insert(
        'preferences',
        preferences.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}