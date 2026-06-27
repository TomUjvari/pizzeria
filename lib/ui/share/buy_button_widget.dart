import 'package:flutter/material.dart';

import '../../models/cart.dart';
import '../../models/pizza.dart';

class BuyButtonWidget extends StatelessWidget {
  final Pizza _pizza;
  final Cart _cart;
  const BuyButtonWidget(this._pizza, this._cart, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade800,
          ),
          onPressed: () {
            print('Commander une pizza');
            _cart.addProduct(_pizza);
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(width: 5),
              Text("Commander"),
            ],
          ),
        )
      ],
    );
  }
}
