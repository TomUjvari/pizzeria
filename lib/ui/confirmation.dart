import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'share/pizzeria_style.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  String _orderType = 'Sur place';
  String _paymentMethod = 'Carte de crédit';

  final List<String> _orderTypes = ['Sur place', 'À emporter', 'Livraison à domicile'];
  final List<String> _paymentMethods = ['Carte de crédit', 'PayPal', 'Sur place'];

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var format = NumberFormat("#.## €");

    double totalTTC = cart.totalPrice;
    double totalHT = totalTTC / 1.2;
    double tva = totalTTC - totalHT;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type de commande', style: PizzeriaStyle.headerTextStyle),
            Column(
              children: _orderTypes.map((type) => RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: _orderType,
                onChanged: (value) {
                  setState(() {
                    _orderType = value!;
                  });
                },
              )).toList(),
            ),
            const Divider(),
            Text('Moyen de paiement', style: PizzeriaStyle.headerTextStyle),
            Column(
              children: _paymentMethods.map((method) => RadioListTile<String>(
                title: Text(method),
                value: method,
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              )).toList(),
            ),
            const Divider(),
            _buildPriceRow('Total HT', format.format(totalHT)),
            _buildPriceRow('TVA (20%)', format.format(tva)),
            _buildPriceRow('Total TTC', format.format(totalTTC), isTotal: true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context, cart);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Commander'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isTotal ? PizzeriaStyle.priceTotalTextStyle : PizzeriaStyle.regularTextStyle),
          Text(value, style: isTotal ? PizzeriaStyle.priceTotalTextStyle : PizzeriaStyle.regularTextStyle),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Cart cart) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Commande confirmée'),
          content: const Text('Votre commande a été enregistrée avec succès !'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                cart.clear();
                Navigator.of(context).pop(); // Fermer le dialog
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false); // Retour au menu principal
              },
            ),
          ],
        );
      },
    );
  }
}
