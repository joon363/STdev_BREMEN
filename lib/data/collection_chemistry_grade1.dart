import '../models/card_item.dart';
import '../constants/card_styles.dart';

final Map<String, List<CardItem>> chemistryGrade1 = {
  "물질의 상태": [
    CardItem(
      name: "고체, 액체, 기체",
      imagePath: "lib/assets/icons/states_of_matter.png",
      isUnlocked: true,
      rarity: Rarity.common,
      description: "물질은 고체, 액체, 기체의 세 가지 상태로 존재하며 상태에 따라 모양과 부피가 달라집니다.",
    ),
    CardItem(
      name: "입자의 운동",
      imagePath: "assets/images/particle_motion.png",
      isUnlocked: false,
      rarity: Rarity.rare,
      description: "입자는 끊임없이 운동하며, 상태에 따라 운동의 자유도와 배열이 달라집니다.",
    ),
  ],
  "물질의 성질": [
    CardItem(
      name: "밀도",
      imagePath: "lib/assets/icons/density.png",
      isUnlocked: true,
      rarity: Rarity.rare,
      description: "밀도는 단위 부피당 질량을 나타내며, 같은 부피라도 질량이 다를 수 있습니다.",
    ),
    CardItem(
      name: "용해성과 용해도",
      imagePath: "assets/images/solubility.png",
      isUnlocked: false,
      rarity: Rarity.legendary,
      description: "물질이 용매에 녹는 성질을 용해성이라 하며, 용해도는 녹을 수 있는 최대 양을 의미합니다.",
    ),
  ],
  "혼합물과 분리": [
    CardItem(
      name: "여과 실험",
      imagePath: "lib/assets/icons/filtration.png",
      isUnlocked: true,
      rarity: Rarity.common,
      description: "혼합물을 여과 장치를 통해 분리할 수 있습니다. 예: 물과 모래.",
    ),
    CardItem(
      name: "증류",
      imagePath: "assets/images/distillation.png",
      isUnlocked: false,
      rarity: Rarity.rare,
      description: "끓는점 차이를 이용하여 액체 혼합물을 분리하는 방법입니다.",
    ),
  ],
};
