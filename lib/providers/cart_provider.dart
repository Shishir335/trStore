import 'package:flutter/material.dart';
import 'package:tr_store/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> cartProducts = [];

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
      cartProducts.add(Product(
          id: cartProduct.id,
          title: cartProduct.title,
          content: cartProduct.content,
          image: cartProduct.image,
          quantity: 1));
    } else {
      cartProducts[index].quantity = cartProducts[index].quantity! + 1;
    }
    notifyListeners();
  }

  removeFromCart(Product cartProduct) {
    int index =
        cartProducts.indexWhere((element) => element.id == cartProduct.id);
    if (index == -1) {
    } else {
      if (cartProducts[index].quantity! < 2) {
        cartProducts.removeAt(index);
        // cartProducts.removeWhere((element) => element.id == cartProduct.id);
      } else {
        cartProducts[index].quantity = cartProducts[index].quantity! - 1;
      }
    }
    notifyListeners();
  }
}
