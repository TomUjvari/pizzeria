import 'package:flutter/material.dart';
import 'package:pizzeria/ui/salade_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import '../models/salade.dart';
import '../service/pizzeria_service.dart';

class SaladeList extends StatefulWidget {
  const SaladeList({super.key});

  @override
  State<SaladeList> createState() => _SaladeListState();
}

class _SaladeListState extends State<SaladeList> {
  late Future<List<Salade>> _salades;
  final PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    super.initState();
    _salades = _service.fetchSalades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Nos Salades'),
      body: FutureBuilder<List<Salade>>(
        future: _salades,
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

  ListView _buildListView(List<Salade> salades) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: salades.length,
      itemBuilder: (context, index) {
        return _buildRow(salades[index]);
      },
    );
  }

  Widget _buildRow(Salade salade) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaladeDetails(salade: salade)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  '${PizzeriaService.saladeImageUri}/${salade.image}',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        height: 180,
                        color: Colors.grey[800],
                        child: const Icon(Icons.eco, size: 64, color: Colors.white24),
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
                      '${salade.price} €',
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
                    salade.title,
                    style: PizzeriaStyle.headerTextStyle.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    salade.ingredients,
                    style: PizzeriaStyle.regularTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: BuyButtonWidget(salade),
            ),
          ],
        ),
      ),
    );
  }
}
