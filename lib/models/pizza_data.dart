import 'package:pizzeria/models/pizza.dart';

class PizzaData {
  static List<Pizza> buildList() {
    List<Pizza> list = [];
    list.add(Pizza(id: 1, title: "Barbecue", garniture: "La garniture", image: "pizza-bbq.jpg", price: 8));
    list.add(Pizza(id: 2, title: "Hawai", garniture: "La garniture", image: "pizza-hawai.jpg", price: 9));
    list.add(Pizza(id: 3, title: "Epinards", garniture: "La garniture", image: "pizza-epinards.jpg", price: 7));
    list.add(Pizza(id: 4, title: "Végétarienne", garniture: "La garniture", image: "pizza-veggie.jpg", price: 10));
    return list;
  }
}
