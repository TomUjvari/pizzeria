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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _buildListView(List<Boisson> boissons) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: boissons.length,
      itemBuilder: (context, index) {
        return _buildRow(boissons[index]);
      },
    );
  }

  Widget _buildRow(Boisson boisson) {
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
                MaterialPageRoute(builder: (context) => BoissonDetails(boisson: boisson)),
              );
            },
            child: _buildBoissonDetails(boisson),
          ),
          BuyButtonWidget(boisson),
        ],
      ),
    );
  }

  Widget _buildBoissonDetails(Boisson boisson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(boisson.title),
          subtitle: Text('Sucre : ${boisson.sugar}g'),
          leading: const Icon(Icons.local_drink),
        ),
        // Image.network(
        //   '${PizzeriaService.imageUri}/${boisson.image}',
        //   height: 120,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        //   errorBuilder: (context, error, stackTrace) =>
        //       const Icon(Icons.error, size: 120),
        // ),
        // Since we don't have images for drinks yet in the API description, 
        // and imageUri points to pizzas, let's use a placeholder or check if they exist.
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue.shade100,
          child: const Icon(Icons.local_drink, size: 80, color: Colors.blue),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text('Prix : ${boisson.price}€'),
        ),
      ],
    );
  }
}
