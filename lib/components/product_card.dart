import 'package:flutter/material.dart';
import 'package:tr_store/utils/colors.dart';
import 'package:tr_store/screens/details_screen.dart';
import 'package:tr_store/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailsScreen(product: product);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Hero(
              tag: product.id!,
              child: Image.network(product.image!,
                  height: 50, width: 50, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(children: [
                Text(product.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(product.content!,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              ]),
            ),
            const SizedBox(width: 10),
            Container(height: 50, width: 50, color: Colors.red),
          ]),
        ),
      ),
    );
  }
}
