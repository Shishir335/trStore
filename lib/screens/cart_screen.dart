import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/components/product_card.dart';
import 'package:tr_store/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'CartScreen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: provider.cartProducts.isEmpty
              ? const Center(
                  child: Text(
                  'Cart is empty.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
              : ListView.separated(
                  itemCount: provider.cartProducts.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return ProductCard(product: provider.cartProducts[index]);
                  },
                ),
        ),
      );
    });
  }
}
