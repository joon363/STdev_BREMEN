import '../constants/card_styles.dart';

class CardItem {
  final String name;
  final String imagePath;
  final bool isUnlocked;
  final Rarity rarity;
  final String description;

  const CardItem({
    required this.name,
    required this.imagePath,
    required this.isUnlocked,
    required this.rarity,
    required this.description,
  });
}
