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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoissonDetails(boisson: boisson)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'boisson-${boisson.id}',
                  child: Image.network(
                    '${PizzeriaService.boissonImageUri}/${boisson.image}',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                          height: 180,
                          color: Colors.grey[800],
                          child: const Icon(Icons.local_drink, size: 64, color: Colors.white24),
                        ),
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
                      '${boisson.price} €',
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
                    boisson.title,
                    style: PizzeriaStyle.headerTextStyle.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Taux de sucre : ${boisson.sugar}g',
                    style: PizzeriaStyle.regularTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: BuyButtonWidget(boisson),
            ),
          ],
        ),
      ),
    );
  }
}
