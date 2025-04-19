import '../models/card_item.dart';
import '../constants/card_styles.dart';

final Map<String, List<CardItem>> physicsGrade3 = {
  "자석의 성질": [
    CardItem(
      name: "자석의 극",
      imagePath: "assets/images/magnet_pole.png",
      isUnlocked: true,
      rarity: Rarity.common,
      description: "자석에는 N극과 S극이 있으며, 같은 극끼리는 밀어내고 다른 극끼리는 끌어당기는 성질이 있습니다.",
    ),
    CardItem(
      name: "자석의 작용 범위",
      imagePath: "assets/images/magnet_range.png",
      isUnlocked: false,
      rarity: Rarity.rare,
      description: "자석은 닿지 않아도 가까운 곳에 있는 철 물체를 끌어당길 수 있습니다. 이 범위를 자력이라고 합니다.",
    ),
    CardItem(
      name: "자석과 철",
      imagePath: "assets/images/magnet_attract.png",
      isUnlocked: true,
      rarity: Rarity.common,
      description: "자석은 유리나 나무를 통과해서도 철을 끌어당길 수 있습니다.",
    ),
  ],
  "힘과 운동": [
    CardItem(
      name: "물체를 미는 힘",
      imagePath: "assets/images/push.png",
      isUnlocked: true,
      rarity: Rarity.common,
      description: "물체를 앞으로 움직이게 하는 힘으로, 손으로 밀 때 발생합니다.",
    ),
    CardItem(
      name: "물체를 당기는 힘",
      imagePath: "assets/images/pull.png",
      isUnlocked: false,
      rarity: Rarity.common,
      description: "물체를 자신 쪽으로 끌어당기는 힘입니다.",
    ),
    CardItem(
      name: "힘의 방향과 운동",
      imagePath: "assets/images/force_direction.png",
      isUnlocked: true,
      rarity: Rarity.rare,
      description: "힘이 작용하는 방향에 따라 물체는 밀리거나 당겨지며, 움직이는 방향이 바뀔 수 있습니다.",
    ),
    CardItem(
      name: "힘의 크기 비교",
      imagePath: "assets/images/force_size.png",
      isUnlocked: false,
      rarity: Rarity.legendary,
      description: "작은 힘과 큰 힘이 작용할 때 물체의 움직임은 다르게 나타납니다.",
    ),
  ],
  "물체의 움직임": [
    CardItem(
      name: "공 굴리기 실험",
      imagePath: "assets/images/ball_roll.png",
      isUnlocked: true,
      rarity: Rarity.common,
      description: "평평한 곳에서 굴린 공은 계속 움직이며, 힘이 닿지 않으면 점점 멈춥니다.",
    ),
    CardItem(
      name: "기울기와 속력",
      imagePath: "assets/images/slope_speed.png",
      isUnlocked: false,
      rarity: Rarity.rare,
      description: "기울기가 클수록 공은 더 빠르게 굴러갑니다. 이는 중력에 의해 가속되기 때문입니다.",
    ),
    CardItem(
      name: "속력의 변화 관찰",
      imagePath: "assets/images/speed_change.png",
      isUnlocked: true,
      rarity: Rarity.rare,
      description: "경사면의 길이나 높이를 바꾸면 속력에 어떤 변화가 있는지 확인할 수 있습니다.",
    ),
  ],
};