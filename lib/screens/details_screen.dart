import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/models/product.dart';
import 'package:tr_store/providers/products_provider.dart';
import 'package:tr_store/screens/cart_screen.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.product.title!),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Hero(
                      tag: widget.product.id!,
                      child: Image.network(widget.product.image!,
                          height: MediaQuery.of(context).size.width / 2,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 10),
                    Text(widget.product.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 20),
                    Text(widget.product.content!),
                    const SizedBox(height: 20),
                  ]),
                ),
              ),
              Container(height: 60, width: double.infinity, color: Colors.red)
            ],
          ),
        ),
      );
    });
  }

  static getArguments(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments;
  }
}
