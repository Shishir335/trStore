import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/components/cart_icon.dart';
import 'package:tr_store/models/product.dart';
import 'package:tr_store/providers/cart_provider.dart';
import 'package:tr_store/providers/products_provider.dart';
import 'package:tr_store/utils/colors.dart';

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
          actions: const [CartIcon()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Hero(
                      tag: widget.product.id!,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.primaryColor.withOpacity(.5))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.product.image!,
                              height: MediaQuery.of(context).size.width / 2,
                              width: double.infinity,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(widget.product.title!,
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Category: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.secondaryColor)),
                        Text(widget.product.category!,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(widget.product.content!,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                  ]),
                ),
              ),
              Consumer<CartProvider>(builder: (context, provider, _) {
                Product? cartProduct = provider.getProduct(widget.product.id!);
                return InkWell(
                  onTap: () {
                    if (cartProduct == null) {
                      provider.addToCart(widget.product);
                    }
                  },
                  child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.secondaryColor),
                      child: Center(
                          child: cartProduct != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              provider.updateProduct(
                                                  widget.product, false);
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 30,
                                              color: Colors.white,
                                            )),
                                        Text(cartProduct.quantity.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        IconButton(
                                            onPressed: () {
                                              provider.updateProduct(
                                                  widget.product, true);
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              size: 30,
                                              color: Colors.white,
                                            )),
                                      ]),
                                )
                              : const Text('Add to cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white)))),
                );
              })
            ],
          ),
        ),
      );
    });
  }
}
