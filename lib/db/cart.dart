import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:tr_store/models/product.dart';

class DatabaseHelper {
  static Future<void> createTables(sql.Database db) async {
    await db.execute("""
      CREATE TABLE cartItems (
        cartId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id INTEGER,
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
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('cart.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("........creating a table........");
      await createTables(database);
    });
  }

  static Future<int> addToCart(Product product) async {
    final db = await DatabaseHelper.db();

    final data = {
      'id': product.id,
      'title': product.title,
      'url': product.url,
      'slug': product.slug,
      'content': product.content,
      'image': product.image,
      'thumbnail': product.thumbnail,
      'status': product.status,
      'category': product.category,
      'quantity': 1
    };

    final id = await db.insert('cartItems', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await DatabaseHelper.db();
    return db.query("cartItems", orderBy: "cartId");
  }

  static Future<List<Map<String, dynamic>>> getCartItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query("cartItems", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> updateCartItem(Product product, bool increase) async {
    final db = await DatabaseHelper.db();

    final getUpdateItem = await getCartItem(product.id!);
    final productFromDb = Product.fromJson(getUpdateItem[0]);

    if (increase == false && productFromDb.quantity! < 2) {
      deleteCartItem(productFromDb.id!);
    } else {
      final data = {
        'id': product.id,
        'title': product.title,
        'url': product.url,
        'slug': product.slug,
        'content': product.content,
        'image': product.image,
        'thumbnail': product.thumbnail,
        'status': product.status,
        'category': product.category,
        'quantity': increase
            ? productFromDb.quantity! + 1
            : productFromDb.quantity! - 1,
      };

      await db.update("cartItems", data,
          where: "id = ?", whereArgs: [getUpdateItem[0]['id']]);
    }
  }

  static Future<void> deleteCartItem(int id) async {
    final db = await DatabaseHelper.db();

    try {
      await db.delete("cartItems", where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print(e);
      print('could not delete');
    }
  }
}
