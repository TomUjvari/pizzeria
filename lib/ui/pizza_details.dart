import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

import '../models/option_item.dart';
import '../models/pizza.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza _pizza;

  const PizzaDetails({
    Key? key,
    required Pizza pizza,
  })  : _pizza = pizza,
        super(key: key);

  @override
  _PizzaDetailsState createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._pizza.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          Text(
            widget._pizza.title,
            style: PizzeriaStyle.pageTitleStyle,
          ),
          Image.asset(
            'assets/images/pizzas/${widget._pizza.image}',
            height: 180,
          ),
          Text(
            'Recette',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(widget._pizza.garniture),
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
          TotalWidget(total: widget._pizza.total),
          BuyButtonWidget(),
        ],
      ),
    );
  }

  Widget _buildDropDownPates() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.pates[widget._pizza.pate],
      items: _buildDropDownItem(Pizza.pates),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget._pizza.pate = item.value;
          });
        }
      },
    );
  }

  Widget _buildDropDownTailles() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.tailles[widget._pizza.taille],
      items: _buildDropDownItem(Pizza.tailles),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget._pizza.taille = item.value;
          });
        }
      },
    );
  }

  Widget _buildDropDownSauces() {
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.sauces[widget._pizza.sauce],
      items: _buildDropDownItem(Pizza.sauces),
      onChanged: (item) {
        if (item != null) {
          setState(() {
            widget._pizza.sauce = item.value;
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