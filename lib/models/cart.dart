import 'package:pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart {
  final List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);
    if (index == -1) {
      // Ajout
      _items.add(CartItem(pizza));
    } else {
      // Incrémente la quantité
      CartItem item = _items[index];
      item.quantity++;
    }
  }

  void removeProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);
    if (index != -1) {
      // Suppression
      _items.removeAt(index);
    }
  }

  int findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.pizza.total * item.quantity;
    }
    return total;
  }
}
