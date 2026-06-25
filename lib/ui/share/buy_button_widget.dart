import 'package:flutter/material.dart';

class BuyButtonWidget extends StatelessWidget {
  const BuyButtonWidget({super.key});

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
