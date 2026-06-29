import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/pizza.dart';

class PizzaStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/pizzas.json');
  }

  Future<List<Pizza>> loadPizzas() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }
      String contents = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(contents);
      return jsonList.map((json) => Pizza.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> savePizzas(List<Pizza> pizzas) async {
    final file = await _localFile;
    String jsonString = jsonEncode(pizzas.map((p) => p.toJson()).toList());
    return file.writeAsString(jsonString);
  }
}
