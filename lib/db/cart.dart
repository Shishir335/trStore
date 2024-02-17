import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tr_store/models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Database _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        slug TEXT,
        url TEXT,
        title TEXT,
        content TEXT,
        image TEXT,
        thumbnail TEXT,
        status TEXT,
        category TEXT,
        quantity INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    print(product.toMap());
    return await _database.insert('products', product.toMap());
  }

  Future<List<Product>> getTasks() async {
    final List<Map<String, dynamic>> maps = await _database.query('products');
    return List.generate(maps.length, (index) {
      return Product(id: maps[index]['id'], title: maps[index]['title']);
    });
  }

  Future<int> updateTask(Product product) async {
    return await _database.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteTask(int taskId) async {
    return await _database.delete(
      'products',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
