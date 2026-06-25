import 'option_item.dart';

class Pizza {
  final int id;
  final String title;
  final String garniture;
  final String image;
  final double price;

  // La sélection de l'utilisateur
  int pate = 0;
  int taille = 1;
  int sauce = 0;

  // Les options possibles
  static final List<OptionItem> pates = [
    OptionItem(0, "Pâte fine"),
    OptionItem(1, "Pâte épaisse", supplement: 1),
  ];

  static final List<OptionItem> tailles = [
    OptionItem(0, "Small", supplement: -1),
    OptionItem(1, "Medium"),
    OptionItem(2, "Large", supplement: 2),
    OptionItem(3, "Extra large", supplement: 4),
  ];

  static final List<OptionItem> sauces = [
    OptionItem(0, "Base sauce tomate"),
    OptionItem(1, "Sauce Samouraï", supplement: 2),
  ];

  double get total {
    double total = price;
    total += pates[pate].supplement;
    total += tailles[taille].supplement;
    total += sauces[sauce].supplement;
    return total;
  }

  Pizza({required this.id, required this.title, required this.garniture,
    required this.image, required this.price});
}
