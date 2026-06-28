import 'package:flutter/material.dart';
import 'package:pizzeria/ui/boisson_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import '../models/boisson.dart';
import '../service/pizzeria_service.dart';

class BoissonList extends StatefulWidget {
  const BoissonList({super.key});

  @override
  State<BoissonList> createState() => _BoissonListState();
}

class _BoissonListState extends State<BoissonList> {
  late Future<List<Boisson>> _boissons;
  final PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    super.initState();
    _boissons = _service.fetchBoissons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Nos Boissons'),
      body: FutureBuilder<List<Boisson>>(
        future: _boissons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Impossible de récupérer les données : ${snapshot.error}',
                style: PizzeriaStyle.errorTextStyle,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(color: Colors.amber));
        },
      ),
    );
  }

  ListView _buildListView(List<Boisson> boissons) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: boissons.length,
      itemBuilder: (context, index) {
        return _buildRow(boissons[index]);
      },
    );
  }

  Widget _buildRow(Boisson boisson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: PizzeriaStyle.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoissonDetails(boisson: boisson)),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_drink, size: 40, color: Colors.amber),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      boisson.title,
                      style: PizzeriaStyle.headerTextStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Taux de sucre : ${boisson.sugar}g',
                      style: PizzeriaStyle.regularTextStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${boisson.price} €',
                      style: PizzeriaStyle.subPriceTextStyle,
                    ),
                  ],
                ),
              ),
              BuyButtonWidget(boisson),
            ],
          ),
        ),
      ),
    );
  }
}
