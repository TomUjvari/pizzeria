import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/pizza.dart';

class PizzeriaService {
  // URI de base pour l'appel
  // Ici, l'adresse IP 10.0.2.2 représente le localhost
  static final String uri = 'http://10.0.2.2:8080/api';
  static final String imageUri = 'http://10.0.2.2:8080/static/images/pizzas';

  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];

    try {
      final response = await http.get(Uri.parse('$uri/pizzas'));

      if (response.statusCode == 200) {
        // var json = jsonDecode(response.body);
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for (final value in json) {
          // Création de l'objet pizza avec le JSON :
          list.add(Pizza.fromJson(value));
        }
      } else {
        throw Exception('Impossible de récupérer les pizzas');
      }
    } catch (e) {
      rethrow;
    }
    return list;
  }
}
