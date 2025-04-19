import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';
import 'CardDetail.dart';
import 'package:stdev_bremen/data/collection_registry.dart';
import '../data/collection_registry.dart';
import '../models/collection_meta.dart';

const purple = Color(0xFF0E06ED);
const card_purple = Color(0xFFEEE9FF);

class CollectionDetailPage extends StatelessWidget {
  final String? collectionKey;
  final String? title;
  final Map<String, List<CardItem>>? data;

  const CollectionDetailPage({this.collectionKey, this.title, this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final effectiveTitle = title ?? args?['title'];
    final rawData = data ?? args?['data'];

    final CollectionMeta? collection = collectionKey != null ? collectionRegistry[collectionKey!] : null;
    final resolvedTitle = effectiveTitle ?? collection?.title ?? "컬렉션";

    final resolvedData = (rawData ?? collection?.data)?.map(
          (key, value) => MapEntry(key, value.map((e) => _toCardItem(e)).toList()),
    );

    if (resolvedData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("컬렉션 없음")),
        body: const Center(child: Text("존재하지 않는 컬렉션입니다.")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new, color: purple, size: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    resolvedTitle,
                    style: const TextStyle(
                      fontSize: 30,
                      color: purple,
                      fontFamily: 'Kakao',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: resolvedData.entries.map<Widget>((entry) {
                    final subject = entry.key;
                    final items = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("⭐", style: TextStyle(fontSize: 22)),
                            const SizedBox(width: 4),
                            Text(
                              subject,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Kakao',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: items.map<Widget>((item) => CollectionCard(item: item)).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static CardItem _toCardItem(dynamic e) {
    if (e is CardItem) return e;
    if (e is Map<String, dynamic>) {
      return CardItem(
        name: e['name'] ?? '제목 없음',
        imagePath: e['imagePath'] ?? 'assets/images/placeholder.png',
        isUnlocked: e['isUnlocked'] ?? true,
        rarity: Rarity.values.firstWhere(
              (r) => r.toString() == 'Rarity.${e['rarity']}',
          orElse: () => Rarity.common,
        ),
        description: e['description'] ?? '',
      );
    }
    throw ArgumentError('Invalid card item data');
  }
}

class CollectionCard extends StatelessWidget {
  final CardItem item;

  const CollectionCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!item.isUnlocked) return;
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => CardDetailPage(card: item),
        );
      },
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: item.isUnlocked ? card_purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 🔸 Rare 카드: 퍼플 그라디언트
              if (item.rarity == Rarity.rare && item.isUnlocked)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white10,
                          Color(0xFF0E06ED),
                        ],
                      ),
                    ),
                  ),
                ),

              // 🔒 잠금 카드: 탑다운 어두운 그라디언트
              if (!item.isUnlocked)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0x66000000),
                        ],
                      ),
                    ),
                  ),
                ),

              // 🔹 카드 이미지
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.isUnlocked ? item.imagePath : 'lib/assets/icons/lock_icon.png',
                        height: 110,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.lock_outline, size: 48, color: Colors.grey);
                        },
                      ),
                      const SizedBox(height: 8),
                      if (item.isUnlocked)
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Kakao',
                            color: (item.rarity == Rarity.rare) ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}