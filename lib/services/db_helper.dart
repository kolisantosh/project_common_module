/*
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  // Open/Create Database
  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'mydb.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create Table
  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  // Insert
  static Future<int> insertUser(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('users', data);
  }

  // Get All
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Update
  static Future<int> updateUser(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('users', data, where: 'id = ?', whereArgs: [id]);
  }

  // Delete
  static Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
*/
