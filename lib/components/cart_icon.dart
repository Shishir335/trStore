import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/providers/cart_provider.dart';
import 'package:tr_store/screens/cart_screen.dart';
import 'package:tr_store/utils/colors.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
        },
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.shopping_cart_outlined),
            if (provider.cartProducts.isNotEmpty)
              Positioned(
                top: -12,
                right: -5,
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(provider.cartProducts.length.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
              )
          ],
        ),
        padding: const EdgeInsets.only(right: 10),
      );
    });
  }
}
