import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tr_store/utils/url.dart';

class ApiService {
  Future<dynamic> getProducts() async {
    dynamic products;
    try {
      final result = await http.get(Uri.parse(productsUrl));
      products = result.body;

      print(result.body);
    } catch (e) {
      print(e);
    }

    return jsonDecode(products);
  }
}
