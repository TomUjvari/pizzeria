import 'package:flutter/material.dart';
import '../../models/cart.dart';
import '../panier.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Cart cart;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Panier(cart)),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
