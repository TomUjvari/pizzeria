import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
    Cart? cart, // Keep it for compatibility if needed, but we'll use Provider
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    int totalItems = cart.totalItems();

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/panier');
          },
          icon: Badge(
            label: Text('$totalItems'),
            isLabelVisible: totalItems > 0,
            child: const Icon(Icons.shopping_cart),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
