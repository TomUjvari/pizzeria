import 'option_item.dart';
import 'product.dart';

class Boisson extends Product {
  final int sugar;

  int quantityIndex = 0;
  bool iceCubes = false;

  static final List<OptionItem> quantities = [
    OptionItem(0, "33cl"),
    OptionItem(1, "50cl", supplement: 1),
    OptionItem(2, "100cl", supplement: 2),
  ];

  @override
  double get total {
    return price + quantities[quantityIndex].supplement;
  }

  Boisson({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
    required this.sugar,
  });

  Boisson.fromJson(Map<String, dynamic> json)
      : sugar = json['sugar'],
        super(
          id: json['id'] ?? 0,
          title: json['title'],
          image: json['image'] ?? 'boisson.jpg',
          price: json['price'].toDouble(),
        );
}
