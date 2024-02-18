import 'package:flutter/material.dart';
import 'package:tr_store/db/cart.dart';
import 'package:tr_store/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> cartProducts = [];

  CartProvider() {
    loadTasks();
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
    int index =
        cartProducts.indexWhere((element) => element.id == cartProduct.id);
    if (index == -1) {
      addProduct(cartProduct);
    }
    notifyListeners();
  }

  Future<void> loadTasks() async {
    final data = await DatabaseHelper.getCartItems();
    cartProducts.clear();
    for (var element in data) {
      cartProducts.add(Product.fromJson(element));
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await DatabaseHelper.addToCart(product);
    await loadTasks(); // Reload tasks after insertion
  }

  Future<void> updateProduct(Product product, bool increase) async {
    await DatabaseHelper.updateCartItem(product, increase);

    await loadTasks(); // Reload tasks after update
  }

  Future<void> deleteProduct(Product product) async {
    await DatabaseHelper.deleteCartItem(product.id!);

    await loadTasks(); // Reload tasks after update
  }
}
