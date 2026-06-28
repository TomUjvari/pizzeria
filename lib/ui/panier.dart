import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../service/pizzeria_service.dart';

class Panier extends StatelessWidget {
  final bool hideAppBar;

  const Panier({super.key, this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var format = NumberFormat("#.## €");

    Widget content = Column(
      children: [
        Expanded(
          child: _CartList(),
        ),
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: PizzeriaStyle.surfaceColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL',
                    style: PizzeriaStyle.priceSubTotalTextStyle,
                  ),
                  Text(
                    format.format(cart.totalPrice),
                    style: PizzeriaStyle.priceTotalTextStyle,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: cart.totalItems() == 0 ? null : () {
                    Navigator.pushNamed(context, '/confirmation');
                  },
                  child: const Text('COMMANDER MAINTENANT'),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (hideAppBar) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MON PANIER'),
      ),
      body: content,
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var format = NumberFormat("#.## €");

    if (cart.totalItems() == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_basket_outlined, size: 80, color: Colors.white10),
            const SizedBox(height: 16),
            Text(
              'Votre panier est vide',
              style: PizzeriaStyle.regularTextStyle,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cart.totalItems(),
      itemBuilder: (context, index) {
        var cartItem = cart.getCartItem(index);
        var product = cartItem.product;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: PizzeriaStyle.surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: product is Pizza
                      ? Image.network(
                    '${PizzeriaService.imageUri}/${product.image}',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(width: 70, height: 70, color: Colors.grey[800], child: const Icon(Icons.local_pizza)),
                  )
                      : Container(
                    width: 70,
                    height: 70,
                    color: Colors.amber.withOpacity(0.1),
                    child: const Icon(Icons.local_drink, color: Colors.amber),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: PizzeriaStyle.headerTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        format.format(product.total),
                        style: PizzeriaStyle.itemPriceTextStyle,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        _QuantityButton(
                          icon: Icons.remove,
                          onPressed: () => cart.removeProduct(product),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        _QuantityButton(
                          icon: Icons.add,
                          onPressed: () => cart.addProduct(product),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      format.format(product.total * cartItem.quantity),
                      style: TextStyle(
                        color: Colors.amber.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.amber),
      ),
    );
  }
}
