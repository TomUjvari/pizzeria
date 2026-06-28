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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            cart.addProduct(_product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.amber,
                content: Text(
                  '${_product.title} ajouté au panier',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_shopping_cart, size: 20),
              SizedBox(width: 8),
              Text("AJOUTER AU PANIER"),
            ],
          ),
        )
      ],
    );
  }
}
