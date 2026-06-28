import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                print('Commande validée pour un montant de ${format.format(cart.totalPrice)}');
                // On pourrait vider le panier ou naviguer vers une page de confirmation
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
        return Card(
          child: ListTile(
            leading: Image.network(
              '${PizzeriaService.imageUri}/${cartItem.pizza.image}',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.local_pizza),
            ),
            title: Text(cartItem.pizza.title),
            subtitle: Text(
              'Prix : ${format.format(cartItem.pizza.total)}\n'
              'Sous-total : ${format.format(cartItem.pizza.total * cartItem.quantity)}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.red,
                  onPressed: () => cart.removeProduct(cartItem.pizza),
                ),
                Text('${cartItem.quantity}', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.green,
                  onPressed: () => cart.addProduct(cartItem.pizza),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
