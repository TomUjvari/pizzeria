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
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          Text(
            widget.boisson.title,
            style: PizzeriaStyle.pageTitleStyle,
          ),
          Container(
            height: 180,
            color: Colors.blue.shade100,
            child: const Icon(Icons.local_drink, size: 120, color: Colors.blue),
          ),
          Text(
            'Taux de sucre',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Slider(
            value: widget.boisson.sugar.toDouble(),
            min: 0,
            max: 50,
            divisions: 50,
            label: '${widget.boisson.sugar}g',
            onChanged: null, // Read-only
          ),
          Text(
            'Options',
            style: PizzeriaStyle.headerTextStyle,
          ),
          CheckboxListTile(
            title: const Text("Glaçons"),
            value: widget.boisson.iceCubes,
            onChanged: (bool? value) {
              setState(() {
                widget.boisson.iceCubes = value ?? false;
              });
            },
          ),
          Text(
            'Quantité sélectionnée',
            style: PizzeriaStyle.headerTextStyle,
          ),
          _buildDropDownQuantities(),
          TotalWidget(total: widget.boisson.total),
          BuyButtonWidget(widget.boisson),
        ],
      ),
    );
  }

  Widget _buildDropDownQuantities() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Boisson.quantities[widget.boisson.quantityIndex],
      items: _buildDropDownItem(Boisson.quantities),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget.boisson.quantityIndex = item.value;
          });
        }
      },
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
