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
        title: const Text('CONFIRMATION'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('TYPE DE COMMANDE'),
            Container(
              decoration: BoxDecoration(
                color: PizzeriaStyle.surfaceColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: _orderTypes.map((type) => RadioListTile<String>(
                  title: Text(type, style: const TextStyle(color: Colors.white70)),
                  value: type,
                  activeColor: Colors.amber,
                  groupValue: _orderType,
                  onChanged: (value) {
                    setState(() {
                      _orderType = value!;
                    });
                  },
                )).toList(),
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('MOYEN DE PAIEMENT'),
            Container(
              decoration: BoxDecoration(
                color: PizzeriaStyle.surfaceColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: _paymentMethods.map((method) => RadioListTile<String>(
                  title: Text(method, style: const TextStyle(color: Colors.white70)),
                  value: method,
                  activeColor: Colors.amber,
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value!;
                    });
                  },
                )).toList(),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  _buildPriceRow('Total HT', format.format(totalHT)),
                  _buildPriceRow('TVA (20%)', format.format(tva)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: Colors.white10),
                  ),
                  _buildPriceRow('TOTAL À PAYER', format.format(totalTTC), isTotal: true),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context, cart);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text('CONFIRMER LA COMMANDE', style: TextStyle(letterSpacing: 1.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
      child: Text(
        title,
        style: PizzeriaStyle.headerTextStyle.copyWith(
          color: Colors.amber.withOpacity(0.7),
          fontSize: 14,
          letterSpacing: 2,
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
          Text(label, style: isTotal ? PizzeriaStyle.priceTotalTextStyle : PizzeriaStyle.priceSubTotalTextStyle),
          Text(value, style: isTotal ? PizzeriaStyle.priceTotalTextStyle : PizzeriaStyle.priceSubTotalTextStyle),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Cart cart) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Commande confirmée', style: TextStyle(color: Colors.amber)),
          content: const Text('Votre commande a été enregistrée avec succès !', style: TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              onPressed: () {
                cart.clear();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
