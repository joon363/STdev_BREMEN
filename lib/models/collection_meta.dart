import 'card_item.dart';

class CollectionMeta {
  final String id; // 예: "초3_물리"
  final String title; // 예: "초등학교 3학년 물리"
  final String description; // 간단 소개
  final String imagePath; // 컬렉션 썸네일 이미지
  final Map<String, List<CardItem>> data; // 카드 목록

  const CollectionMeta({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.data,
  });
}
