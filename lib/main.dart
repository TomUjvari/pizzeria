import 'package:flutter/material.dart';

import 'models/menu.dart';

void main() {
  runApp(MyApp());
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: _menus.map((menu) => _buildRow(menu)).toList(),
      ),
    );
  }
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
              style: TextStyle(
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