import 'package:flutter/foundation.dart';
import 'package:pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index == -1) {
      _items.add(CartItem(pizza));
    } else {
      CartItem item = _items[index];
      item.quantity++;
    }
    notifyListeners();
  }

  void removeProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index != -1) {
      CartItem item = _items[index];
      if (--item.quantity == 0) {
        _items.removeAt(index);
      }
      notifyListeners();
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
