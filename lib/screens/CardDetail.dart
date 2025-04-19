import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';

const card_purple = Color(0xFFEEE9FF);

class CardDetailPage extends StatelessWidget {
  final CardItem card;

  const CardDetailPage({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
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
              color: card_purple,
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (card.isUnlocked)
                      Image.asset(card.imagePath, height: 240, fit: BoxFit.contain,)
                    else
                      Icon(Icons.lock, size: 80, color: Colors.grey),
                    const SizedBox(height: 20),
                    Text(
                      card.isUnlocked ? card.name : "???",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 0),
                    Text(
                      card.isUnlocked
                          ? "${card.rarity.name.toUpperCase()}"
                          : "수집되지 않은 카드입니다",
                      style: TextStyle(
                        fontSize: 35,
                        color: card.isUnlocked ? rarityColors[card.rarity] : Colors.grey,
                        fontFamily: 'Micro5',
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 0),
                    if (card.isUnlocked)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 여백 추가
                        child: Text(
                          card.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, color: Colors.black87, fontFamily: 'Kakao'),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // 닫기 버튼
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, size: 40),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
