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
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          Text(
            widget.pizza.title,
            style: PizzeriaStyle.pageTitleStyle,
          ),
          Image.network(
            '${PizzeriaService.imageUri}/${widget.pizza.image}',
            height: 180,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, size: 180),
          ),
          Text(
            'Recette',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(widget.pizza.garniture),
          ),
          Text(
            'Pâte et taille sélectionnées',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildDropDownPates()),
              Expanded(child: _buildDropDownTailles()),
            ],
          ),
          Text(
            'Sauce sélectionnée',
            style: PizzeriaStyle.headerTextStyle,
          ),
          _buildDropDownSauces(),
          TotalWidget(total: widget.pizza.total),
          BuyButtonWidget(widget.pizza),
        ],
      ),
    );
  }

  Widget _buildDropDownPates() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.pates[widget.pizza.pate],
      items: _buildDropDownItem(Pizza.pates),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget.pizza.pate = item.value;
          });
        }
      },
    );
  }

  Widget _buildDropDownTailles() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.tailles[widget.pizza.taille],
      items: _buildDropDownItem(Pizza.tailles),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget.pizza.taille = item.value;
          });
        }
      },
    );
  }

  Widget _buildDropDownSauces() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.sauces[widget.pizza.sauce],
      items: _buildDropDownItem(Pizza.sauces),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget.pizza.sauce = item.value;
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
