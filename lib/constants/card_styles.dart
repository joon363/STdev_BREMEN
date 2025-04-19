import 'package:flutter/material.dart';

enum Rarity {
  common,
  rare,
  legendary,
}

const rarityColors = {
  Rarity.common: Colors.grey,
  Rarity.rare: Colors.blue,
  Rarity.legendary: Colors.purple,
};

const lockedCardBackgroundColor = Colors.white;
const unlockedCardBackgroundColor = Colors.white;
