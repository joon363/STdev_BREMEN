import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';
import 'CardDetail.dart';

class CollectionDetailPage extends StatelessWidget {
  final String title;

  const CollectionDetailPage({required this.title, super.key});

  final Map<String, List<CardItem>> data = const {
    "힘과 운동": [
      CardItem(name: "뉴턴의 제1법칙", imagePath: "assets/images/newton.png", isUnlocked: true, rarity: Rarity.common, description: "정지해 있거나 등속 직선 운동을 하는 물체는 외부 힘이 작용하지 않는 한 계속 그 상태를 유지한다.",),
      CardItem(name: "중력 실험", imagePath: "assets/images/gravity.jpg", isUnlocked: true, rarity: Rarity.rare, description: "정지해 있거나 등속 직선 운동을 하는 물체는 외부 힘이 작용하지 않는 한 계속 그 상태를 유지한다.",),
      CardItem(name: "마찰력", imagePath: "assets/images/friction.png", isUnlocked: true, rarity: Rarity.rare, description: "정지해 있거나 등속 직선 운동을 하는 물체는 외부 힘이 작용하지 않는 한 계속 그 상태를 유지한다.",),
      CardItem(name: "등속 운동", imagePath: "assets/images/uniform.png", isUnlocked: false, rarity: Rarity.legendary, description: "정지해 있거나 등속 직선 운동을 하는 물체는 외부 힘이 작용하지 않는 한 계속 그 상태를 유지한다.",),
    ],
    "소리와 진동": [
      CardItem(name: "공명", imagePath: "assets/images/resonance.png", isUnlocked: true, rarity: Rarity.common, description: "정지해 있거나 등속 직선 운동을 하는 물체는 외부 힘이 작용하지 않는 한 계속 그 상태를 유지한다.",),
      CardItem(name: "파형 관찰", imagePath: "assets/images/wave.png", isUnlocked: false, rarity: Rarity.common, description: "정지해 있거나 등속 직선 운동을 하는 물체는 외부 힘이 작용하지 않는 한 계속 그 상태를 유지한다.",),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
          barrierDismissible: true, // 바깥 눌러도 닫힘
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
