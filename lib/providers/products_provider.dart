import 'package:flutter/material.dart';
import 'package:tr_store/api_service/api_service.dart';
import 'package:tr_store/models/product.dart';

class ProductProvider with ChangeNotifier {
  final ApiService apiService;
  ProductProvider({required this.apiService});

  List<Product> allProducts = [];

  getAllProducts() {
    _homeScreenLoader = true;
    apiService.getProducts().then((value) {
      for (var item in value) {
        allProducts.add(Product.fromJson(item));
      }
      changeHomeScreenLoader(false);
    });
  }

  bool _homeScreenLoader = false;
  bool get homeScreenLoader => _homeScreenLoader;

  changeHomeScreenLoader(bool value) {
    _homeScreenLoader = value;
    notifyListeners();
  }
}
