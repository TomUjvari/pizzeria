import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, [this.quantity = 1]);
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Product product) {
    int index = findCartItemIndex(product);
    if (index == -1) {
      _items.add(CartItem(product));
    } else {
      CartItem item = _items[index];
      item.quantity++;
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    int index = findCartItemIndex(product);
    if (index != -1) {
      CartItem item = _items[index];
      if (--item.quantity == 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  int findCartItemIndex(Product product) {
    return _items.indexWhere((element) => 
      element.product.id == product.id && element.product.runtimeType == product.runtimeType
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.product.total * item.quantity;
    }
    return total;
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
