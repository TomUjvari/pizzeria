import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

import '../models/option_item.dart';
import '../models/boisson.dart';

class BoissonDetails extends StatefulWidget {
  final Boisson boisson;

  const BoissonDetails({
    super.key,
    required this.boisson,
  });

  @override
  State<BoissonDetails> createState() => _BoissonDetailsState();
}

class _BoissonDetailsState extends State<BoissonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.boisson.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.amber.withOpacity(0.1),
              child: const Icon(Icons.local_drink, size: 120, color: Colors.amber),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.boisson.title,
                    style: PizzeriaStyle.pageTitleStyle,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'TAUX DE SUCRE',
                    style: PizzeriaStyle.headerTextStyle.copyWith(
                      color: Colors.amber.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.amber,
                      inactiveTrackColor: Colors.white10,
                      thumbColor: Colors.amber,
                      overlayColor: Colors.amber.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: widget.boisson.sugar.toDouble(),
                      min: 0,
                      max: 50,
                      divisions: 50,
                      label: '${widget.boisson.sugar}g',
                      onChanged: null,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(color: Colors.white10),
                  ),
                  Text(
                    'OPTIONS',
                    style: PizzeriaStyle.headerTextStyle.copyWith(
                      color: Colors.amber.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Ajouter des glaçons", style: TextStyle(color: Colors.white70)),
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                    value: widget.boisson.iceCubes,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.boisson.iceCubes = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Format'),
                  _buildDropDownQuantities(),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TotalWidget(total: widget.boisson.total),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: BuyButtonWidget(widget.boisson),
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

  Widget _buildDropDownQuantities() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OptionItem>(
          isExpanded: true,
          value: Boisson.quantities[widget.boisson.quantityIndex],
          items: _buildDropDownItem(Boisson.quantities),
          dropdownColor: const Color(0xFF1E1E1E),
          onChanged: (item) {
            if (item != null) {
              setState(() {
                widget.boisson.quantityIndex = item.value;
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
