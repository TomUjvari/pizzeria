import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../models/pizza_data.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({super.key});

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  List<Pizza> _pizzas = [];

  @override
  void initState() {
    super.initState();
    _pizzas = PizzaData.buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nos Pizzas"),
      ), // AppBar
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _pizzas.length,
        itemBuilder: (context, index) {
          return _buildRow(_pizzas[index]);
        },
      ), // ListView.builder, Scaffold
    );
  }

  _buildRow(Pizza pizza) {
    return Card(
      // color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(pizza.title),
              subtitle: Text(pizza.garniture),
              leading: Icon(Icons.local_pizza),
            ),
            Image.asset(
              'assets/images/pizzas/${pizza.image}',
              height: 120,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(pizza.garniture),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 5),
                      Text("Commander"),
                    ],
                  ),
                  onPressed: () {
                    print('Commander une pizza');
                  },
                ),
              ],
            ),
          ],
        )
    );
  }
}