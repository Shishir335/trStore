import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/components/cart_icon.dart';
import 'package:tr_store/components/product_card.dart';
import 'package:tr_store/components/shimmer.dart';
import 'package:tr_store/providers/products_provider.dart';

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
          actions: const [CartIcon()],
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
                        return ProductCard(
                            product: provider.allProducts[index]);
                      },
                    ));
        }));
  }
}
