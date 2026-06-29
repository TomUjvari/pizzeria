import 'option_item.dart';
import 'product.dart';

class Pizza extends Product {
  final String garniture;

  // La sélection de l'utilisateur
  int pate = 0;
  int taille = 1;
  int sauce = 0;

  // Les options possibles
  static final List<OptionItem> pates = [
    OptionItem(0, "Pâte fine"),
    OptionItem(1, "Pâte épaisse", supplement: 1),
    OptionItem(1, "Pâte garnie", supplement: 2),
  ];

  static final List<OptionItem> tailles = [
    OptionItem(0, "Small", supplement: -1),
    OptionItem(1, "Medium"),
    OptionItem(2, "Large", supplement: 2),
    OptionItem(3, "Extra large", supplement: 4),
  ];

  static final List<OptionItem> sauces = [
    OptionItem(0, "Base sauce tomate"),
    OptionItem(0, "Base crème fraîche"),
  ];

  @override
  double get total {
    double total = price;
    total += pates[pate].supplement;
    total += tailles[taille].supplement;
    total += sauces[sauce].supplement;
    return total;
  }

  Pizza({required super.id, required super.title, required this.garniture,
    required super.image, required super.price});

  Pizza.fromJson(Map<String, dynamic> json) :
        garniture = json['garniture'],
        super(
          id: json['id'],
          title: json['title'],
          image: json['image'],
          price: json["price"].toDouble(),
        ) {
    pate = json['pate'] ?? 0;
    taille = json['taille'] ?? 1;
    sauce = json['sauce'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'garniture': garniture,
      'image': image,
      'price': price,
      'pate': pate,
      'taille': taille,
      'sauce': sauce,
    };
  }
}
