import '../models/collection_meta.dart';

import 'collection_physics_grade3.dart';
import 'collection_chemistry_grade1.dart';

final Map<String, CollectionMeta> collectionRegistry = {
  "중3_물리": CollectionMeta(
    id: "중3_물리",
    title: "중등 3학년 물리",
    description: "자석, 힘, 운동 등 물리 개념을 쉽고 재미있게 배워보세요!",
    imagePath: "assets/images/physics3_thumbnail.png",
    data: physicsGrade3, // 이건 Map<String, List<CardItem>>
  ),
  "중등_화학": CollectionMeta(
    id: "중등_화학",
    title: "중등 화학 기본",
    description: "물질의 상태, 성질, 분리 방법 등 기초 화학 개념을 다룹니다.",
    imagePath: "assets/images/chemistry3_thumbnail.png",
    data: chemistryGrade1,
  ),
};