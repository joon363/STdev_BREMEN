import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';

class CardDetailPage extends StatelessWidget {
  final CardItem card;

  const CardDetailPage({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // ✅ 배경을 투명하게
      insetPadding: const EdgeInsets.all(16),
      child: Center(
        child: Stack(
          children: [
            // 카드 본체
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: card.isUnlocked
                    ? BorderSide(color: rarityColors[card.rarity]!, width: 3)
                    : BorderSide.none,
              ),
              color: card.isUnlocked ? Colors.white : lockedCardBackgroundColor,
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (card.isUnlocked)
                      Image.asset(card.imagePath, height: 120)
                    else
                      Icon(Icons.lock, size: 80, color: Colors.grey),
                    const SizedBox(height: 20),
                    Text(
                      card.isUnlocked ? card.name : "???",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      card.isUnlocked
                          ? "희귀도: ${card.rarity.name.toUpperCase()}"
                          : "수집되지 않은 카드입니다",
                      style: TextStyle(
                        fontSize: 14,
                        color: card.isUnlocked ? rarityColors[card.rarity] : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (card.isUnlocked)
                      Text(
                        card.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                  ],
                ),
              ),
            ),

            // 닫기 버튼
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close, size: 26),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
