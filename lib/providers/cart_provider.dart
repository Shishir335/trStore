import 'package:flutter/material.dart';
import 'package:tr_store/db/cart.dart';
import 'package:tr_store/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> cartProducts = [];

  CartProvider() {
    _init();
  }

  Product? getProduct(int id) {
    Product? product;

    for (var item in cartProducts) {
      if (item.id == id) {
        product = item;
      }
    }

    return product;
  }

  addToCart(Product cartProduct) {
    int index = cartProducts
        .indexWhere((element) => element.id == cartProduct.id);
    if (index == -1) {
      // cartProducts.add();
      addProduct(Product(
          id: cartProduct.id,
          title: cartProduct.title,
          content: cartProduct.content,
          image: cartProduct.image,
          quantity: 1));
    } else {
      cartProducts[index].quantity = cartProducts[index].quantity! + 1;
      updateProduct(cartProducts[index]);
    }
    notifyListeners();
  }

  removeFromCart(Product cartProduct) {
    int index = cartProducts
        .indexWhere((element) => element.id == cartProduct.id);
    if (index == -1) {
    } else {
      if (cartProducts[index].quantity! < 2) {
        // cartProducts.removeAt(index);
        deleteProduct(cartProducts[index]);
      } else {
        cartProducts[index].quantity = cartProducts[index].quantity! - 1;
        updateProduct(cartProducts[index]);
      }
    }
    notifyListeners();
  }

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> _init() async {
    await databaseHelper.initDatabase();
    // Perform other initialization tasks
  }

  Future<void> loadTasks() async {
    await databaseHelper.initDatabase();
    cartProducts = await databaseHelper.getTasks();
    notifyListeners();
  }

  Future<void> addProduct(Product task) async {
    await databaseHelper.insertProduct(task);
    await loadTasks(); // Reload tasks after insertion
  }

  Future<void> updateProduct(Product product) async {
    await databaseHelper.updateTask(product);
    await loadTasks(); // Reload tasks after update
  }

  Future<void> deleteProduct(Product product) async {
    await databaseHelper.deleteTask(product.id!);
    await loadTasks(); // Reload tasks after update
  }
}
