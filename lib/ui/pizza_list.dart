import 'package:flutter/material.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import '../models/pizza.dart';
import '../service/pizzeria_service.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({super.key, cart}); // Keep cart for compatibility if needed

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  late Future<List<Pizza>> _pizzas;
  final PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    super.initState();
    _pizzas = _service.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Nos Pizzas'),
      body: FutureBuilder<List<Pizza>>(
        future: _pizzas,
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _buildListView(List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        return _buildRow(pizzas[index]);
      },
    );
  }

  Widget _buildRow(Pizza pizza) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0), top: Radius.circular(2.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PizzaDetails(pizza: pizza)),
              );
            },
            child: _buildPizzaDetails(pizza),
          ),
          BuyButtonWidget(pizza),
        ],
      ),
    );
  }

  Widget _buildPizzaDetails(Pizza pizza) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: const Icon(Icons.local_pizza),
        ),
        Image.network(
          '${PizzeriaService.imageUri}/${pizza.image}',
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, size: 120),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(pizza.garniture),
        ),
      ],
    );
  }
}
