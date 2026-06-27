import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cart.dart';

class Panier extends StatefulWidget {
  final Cart cart;
  const Panier(this.cart, {super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("#.## €");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.totalItems(),
              itemBuilder: (context, index) {
                return buildItem(widget.cart.getCartItem(index));
              },
            ),
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
                  format.format(widget.cart.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print('Valider');
              },
              child: const Text('Valider'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(CartItem cartItem) {
    var format = NumberFormat("#.## €");
    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_pizza),
        title: Text(cartItem.pizza.title),
        subtitle: Text(
          'Prix : ${format.format(cartItem.pizza.total)}\n'
          'Quantité : ${cartItem.quantity}\n'
          'Sous-total : ${format.format(cartItem.pizza.total * cartItem.quantity)}',
        ),
      ),
    );
  }
}
