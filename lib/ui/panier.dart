import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../service/pizzeria_service.dart';

class Panier extends StatelessWidget {
  const Panier({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var format = NumberFormat("#.## €");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _CartList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  format.format(cart.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: cart.totalItems() == 0 ? null : () {
                Navigator.pushNamed(context, '/confirmation');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Valider'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var format = NumberFormat("#.## €");

    if (cart.totalItems() == 0) {
      return const Center(
        child: Text('Votre panier est vide'),
      );
    }

    return ListView.builder(
      itemCount: cart.totalItems(),
      itemBuilder: (context, index) {
        var cartItem = cart.getCartItem(index);
        var product = cartItem.product;

        return Card(
          child: ListTile(
            leading: product is Pizza
              ? Image.network(
                  '${PizzeriaService.imageUri}/${product.image}',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.local_pizza),
                )
              : const Icon(Icons.local_drink, size: 50, color: Colors.blue),
            title: Text(product.title),
            subtitle: Text(
              'Prix : ${format.format(product.total)}\n'
              'Sous-total : ${format.format(product.total * cartItem.quantity)}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.red,
                  onPressed: () => cart.removeProduct(product),
                ),
                Text('${cartItem.quantity}', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.green,
                  onPressed: () => cart.addProduct(product),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
