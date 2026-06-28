import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../models/product.dart';

class BuyButtonWidget extends StatelessWidget {
  final Product _product;
  const BuyButtonWidget(this._product, {super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade800,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              cart.addProduct(_product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${_product.title} ajouté au panier'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text("Commander"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
