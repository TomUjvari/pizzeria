import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/panier.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:provider/provider.dart';
import 'models/menu.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzéria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Notre pizzéria'),
      routes: {
        '/panier': (context) => const Panier(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title, super.key});

  final _menus = [
    Menu(1, 'Entrées', 'entree.jpg', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizza.jpg', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.jpg', Colors.brown),
    Menu(4, 'Boissons', 'boisson.jpg', Colors.lightBlue),
  ];

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBarWidget(title: title, cart: cart),
      body: ListView.builder(
        itemCount: _menus.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            switch (_menus[index].type) {
              case 2: // Pizza
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PizzaList(cart: cart)),
                );
                break;
              default:
              // Assuming there is a default case or handling for other types
            }
          },
          child: _buildRow(_menus[index]),
        ),
        itemExtent: 180,
      ),
    );
  }

  Widget _buildRow(Menu menu) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: menu.color,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      margin: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/images/menus/${menu.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                menu.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
