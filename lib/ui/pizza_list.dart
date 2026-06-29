import 'package:flutter/material.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import '../models/pizza.dart';
import '../service/pizzeria_service.dart';
import '../services/pizza_storage.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({super.key, cart}); // Keep cart for compatibility if needed

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  late Future<List<Pizza>> _pizzas;
  final PizzeriaService _service = PizzeriaService();
  final PizzaStorage _storage = PizzaStorage();
  List<Pizza> _actualPizzas = [];

  @override
  void initState() {
    super.initState();
    _pizzas = _loadPizzas();
  }

  Future<List<Pizza>> _loadPizzas() async {
    List<Pizza> list = await _storage.loadPizzas();
    if (list.isEmpty) {
      list = await _service.fetchPizzas();
    }
    _actualPizzas = list;
    return list;
  }

  @override
  void dispose() {
    _storage.savePizzas(_actualPizzas);
    super.dispose();
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
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PizzaDetails(pizza: pizza)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  '${PizzeriaService.imageUri}/${pizza.image}',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        height: 180,
                        color: Colors.grey[800],
                      child: const Icon(Icons.local_pizza, size: 64, color: Colors.white24),
                      ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${pizza.price} €',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pizza.title,
                    style: PizzeriaStyle.headerTextStyle.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pizza.garniture,
                    style: PizzeriaStyle.regularTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: BuyButtonWidget(pizza),
            ),
          ],
        ),
      ),
    );
  }
}
