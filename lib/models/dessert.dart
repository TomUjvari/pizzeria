import 'product.dart';

class Dessert extends Product {
  final String description;

  Dessert({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
    required this.description,
  });

  @override
  double get total => price;

  Dessert.fromJson(Map<String, dynamic> json)
      : description = json['description'] ?? '',
        super(
          id: json['id'],
          title: json['title'],
          image: json['image'],
          price: json['price'].toDouble(),
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
    };
  }
}
