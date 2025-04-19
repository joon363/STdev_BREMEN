import 'collection_physics_grade3.dart';
import '../models/collection_meta.dart';

final Map<String, CollectionMeta> collectionRegistry = {
  "초3_물리": CollectionMeta(
    id: "초3_물리",
    title: "초등학교 3학년 물리",
    description: "자석, 힘, 운동 등 물리 개념을 쉽고 재미있게 배워보세요!",
    imagePath: "assets/images/physics3_thumbnail.png",
    data: physicsGrade3, // 이건 Map<String, List<CardItem>>
  ),
};