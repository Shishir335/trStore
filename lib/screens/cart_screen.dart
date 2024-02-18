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
          padding: const EdgeInsets.all(10),
          child: provider.cartProducts.isEmpty
              ? const Center(
                  child: Text(
                  'Cart is empty.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: provider.cartProducts.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          final product = provider.cartProducts[index];
                          return Dismissible(
                              key: Key(product.id.toString()),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20.0),
                                child: const Icon(Icons.delete,
                                    color: Colors.white, size: 36.0),
                              ),
                              onDismissed: (direction) {
                                provider.deleteProduct(product);
                              },
                              child: ProductCard(
                                  product: provider.cartProducts[index]));
                        },
                      ),
                    ),
                    Text('Swipe an Item to Delete',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.bold))
                  ],
                ),
        ),
      );
    });
  }
}
