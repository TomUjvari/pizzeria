import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

import '../models/option_item.dart';
import '../models/pizza.dart';
import '../service/pizzeria_service.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza pizza;

  const PizzaDetails({
    super.key,
    required this.pizza,
    cart, // Keep it for compatibility if needed
  });

  @override
  State<PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.pizza.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'pizza-${widget.pizza.id}',
              child: Image.network(
                '${PizzeriaService.imageUri}/${widget.pizza.image}',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      height: 250,
                      color: Colors.grey[800],
                      child: const Icon(Icons.local_pizza, size: 100, color: Colors.white24),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pizza.title,
                    style: PizzeriaStyle.pageTitleStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'LA RECETTE',
                    style: PizzeriaStyle.headerTextStyle.copyWith(
                      color: Colors.amber.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.pizza.garniture,
                    style: PizzeriaStyle.regularTextStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(color: Colors.white10),
                  ),
                  Text(
                    'PERSONNALISATION',
                    style: PizzeriaStyle.headerTextStyle.copyWith(
                      color: Colors.amber.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Pâte & Taille'),
                  Row(
                    children: [
                      Expanded(child: _buildDropDownPates()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDropDownTailles()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Sauce'),
                  _buildDropDownSauces(),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TotalWidget(total: widget.pizza.total),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: BuyButtonWidget(widget.pizza),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropDownPates() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OptionItem>(
          isExpanded: true,
          value: Pizza.pates[widget.pizza.pate],
          items: _buildDropDownItem(Pizza.pates),
          dropdownColor: const Color(0xFF1E1E1E),
          onChanged: (item) {
            if (item != null) {
              setState(() {
                widget.pizza.pate = item.value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDropDownTailles() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OptionItem>(
          isExpanded: true,
          value: Pizza.tailles[widget.pizza.taille],
          items: _buildDropDownItem(Pizza.tailles),
          dropdownColor: const Color(0xFF1E1E1E),
          onChanged: (item) {
            if (item != null) {
              setState(() {
                widget.pizza.taille = item.value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDropDownSauces() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OptionItem>(
          isExpanded: true,
          value: Pizza.sauces[widget.pizza.sauce],
          items: _buildDropDownItem(Pizza.sauces),
          dropdownColor: const Color(0xFF1E1E1E),
          onChanged: (item) {
            if (item != null) {
              setState(() {
                widget.pizza.sauce = item.value;
              });
            }
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<OptionItem>> _buildDropDownItem(
      List<OptionItem> list) {
    return List.generate(
      list.length,
          (i) => DropdownMenuItem<OptionItem>(
        value: list[i],
        child: Text(list[i].name),
      ),
    );
  }
}
