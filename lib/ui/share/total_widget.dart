import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:intl/intl.dart';

class TotalWidget extends StatelessWidget {
  final double total;

  const TotalWidget({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("#.## €");
    String totalAffiche = format.format(total);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'PRIX TOTAL',
          style: PizzeriaStyle.priceSubTotalTextStyle,
        ),
        Text(
          totalAffiche,
          style: PizzeriaStyle.priceTotalTextStyle,
        ),
      ],
    );
  }
}