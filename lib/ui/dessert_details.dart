import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

import '../models/dessert.dart';
import '../service/pizzeria_service.dart';

class DessertDetails extends StatefulWidget {
  final Dessert dessert;

  const DessertDetails({
    super.key,
    required this.dessert,
  });

  @override
  State<DessertDetails> createState() => _DessertDetailsState();
}

class _DessertDetailsState extends State<DessertDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.dessert.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'dessert-${widget.dessert.id}',
              child: Image.network(
                '${PizzeriaService.dessertImageUri}/${widget.dessert.image}',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      height: 250,
                      color: Colors.grey[800],
                      child: const Icon(Icons.cake, size: 100, color: Colors.white24),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dessert.title,
                    style: PizzeriaStyle.pageTitleStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'DESCRIPTION',
                    style: PizzeriaStyle.headerTextStyle.copyWith(
                      color: Colors.amber.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.dessert.description,
                    style: PizzeriaStyle.regularTextStyle,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TotalWidget(total: widget.dessert.total),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: BuyButtonWidget(widget.dessert),
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
}
