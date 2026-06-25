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
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12.0),
            child: Text(
              'TOTAL',
              style: PizzeriaStyle.priceTotalTextStyle,
              textAlign: TextAlign.end,
            ),
          ),
        ),
        Expanded(
          child: Text(
            totalAffiche,
            style: PizzeriaStyle.priceTotalTextStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }


}