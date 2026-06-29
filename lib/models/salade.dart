import 'product.dart';

class Salade extends Product {
  final String ingredients;

  Salade({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
    required this.ingredients,
  });

  @override
  double get total => price;

  Salade.fromJson(Map<String, dynamic> json)
      : ingredients = json['ingredients'],
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
      'ingredients': ingredients,
    };
  }
}
