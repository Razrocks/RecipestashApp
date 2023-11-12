import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqfliteUtils{
  static Future init() async{
    Future<Database> database = openDatabase(
      path.join(await getDatabasesPath(), 'preference_manager.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE preferences(id INTEGER PRIMARY KEY, r INTEGER, g INTEGER, b INTEGER, darkMode BOOLEAN, notifications BOOLEAN)');
      },
      version: 1,
    );
    return database;
  }
}