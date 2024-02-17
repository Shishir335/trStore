import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/components/product_card.dart';
import 'package:tr_store/components/shimmer.dart';
import 'package:tr_store/models/product.dart';
import 'package:tr_store/providers/products_provider.dart';
import 'package:tr_store/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              padding: const EdgeInsets.only(right: 10),
            )
          ],
        ),
        body: Consumer<ProductProvider>(builder: (context, provider, _) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: provider.homeScreenLoader
                  ? const CustomShimmer()
                  : ListView.separated(
                      itemCount: provider.allProducts.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        Product product = provider.allProducts[index];
                        return ProductCard(product: product);
                      },
                    ));
        }));
  }
}
