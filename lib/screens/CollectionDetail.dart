import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';
import 'CardDetail.dart';
import 'package:stdev_bremen/data/collection_registry.dart';
import '../data/collection_registry.dart';
import '../models/collection_meta.dart';

class CollectionDetailPage extends StatelessWidget {
  final String collectionKey;

  const CollectionDetailPage({required this.collectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionMeta? collection = collectionRegistry[collectionKey];

    if (collection == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("컬렉션 없음")),
        body: const Center(child: Text("존재하지 않는 컬렉션입니다.")),
      );
    }

    final data = collection.data;

    return Scaffold(
      appBar: AppBar(title: Text(collection.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: data.entries.map((entry) {
          final subject = entry.key;
          final items = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items
                    .map((item) => CollectionCard(item: item))
                    .toList(),
              ),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class CollectionCard extends StatelessWidget {
  final CardItem item;

  const CollectionCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return CardDetailPage(card: item);
          },
        );
      },
      child: Card(
        color: item.isUnlocked ? unlockedCardBackgroundColor : lockedCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: item.isUnlocked
              ? BorderSide(color: rarityColors[item.rarity]!, width: 2)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item.isUnlocked
                  ? Image.asset(item.imagePath, height: 60)
                  : Icon(Icons.lock, size: 48, color: Colors.grey),
              const SizedBox(height: 8),
              Text(
                item.isUnlocked ? item.name : "???",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: item.isUnlocked ? Colors.black : Colors.grey,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
