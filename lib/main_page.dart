import 'package:flutter/material.dart';
import 'screens/CollectionHome.dart';
import 'pages/ranking_page.dart';
import 'pages/camera_page.dart';
import 'themes.dart';


class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<bool> _missions = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 10,
            children: [
              // Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '사이언스냅',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColorLight,
                ),
                child: Text(
                  "실시간으로 친구들이 발견하고 있는 법칙들 엿보기 😶",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ),
              // 일일
              DailyMissionCard(),
              // 컬렉션, 랭킹
              Row(
                spacing: 10,
                children: [
                  CollectionCard(),
                  RankingCard(),
                ],
              ),
            ],
          ),
        ),
      ),

      // ✅ 하단 카메라 + 양옆 아이콘
      bottomNavigationBar: BottomBar(),
      floatingActionButton: BottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: secondaryColor,
      shape: const CircleBorder(),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context,'/camera');
        },
        customBorder: const CircleBorder(), // 잔물결도 원형으로
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      color: Colors.white,
      elevation: 10,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.person_outline, size: 30,),
                onPressed: () {
                },
              ),
              Text(
                "프로필",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Container(),
          Container(),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.more_horiz, size: 30),
                onPressed: () {
                },
              ),
              Text(
                "더보기",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}

class DailyMissionCard extends StatelessWidget {
  const DailyMissionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "BREMEN",
                          style: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "님이",
                          style: TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Text(
                      "오늘 해결할 호기심 💡",
                      style: TextStyle(
                        color: primaryColor, fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColorLight
                  ),
                  height: 60,
                  child:
                  Image.asset(
                    'lib/assets/images/main_demon.png',
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: const[
                MissionProgressCard(
                  title: '‘밀면 밀려요’ 챌린지! 작용·반작용 찾아 찍기 👟',
                  current: 1,
                  total: 2,
                ),
                MissionProgressCard(
                  title: '‘미끄러울수록 덜 멈춰요!’ 마찰력 현장포착 📸',
                  current: 2,
                  total: 2,
                ),
                MissionProgressCard(
                  title: '얼음이 녹는 순간, 상태 변화 따라잡기! 🔥',
                  current: 1,
                  total: 3,
                ),
              ],
            )
          ],
        ),)

    );
  }
}

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Material(
            borderRadius: BorderRadius.circular(16),
            elevation: 5, // 그림자 효과 추가 // 그림자 색상 설정
            child: Stack(
              children: [

                // 배경 이미지
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryColorLight,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'lib/assets/images/ranking_card_image.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                // 좌상단 텍스트
                Positioned(
                  top: 15,
                  right: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            '나의 ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '호기심 순위',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '확인하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  highlightColor: primaryColorLight.withAlpha(50),
                  onTap: () {
                    Navigator.pushNamed(context,'/ranking');
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionCard extends StatelessWidget {
  const CollectionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Material(
            borderRadius: BorderRadius.circular(16),
            elevation: 5, // 그림자 효과 추가 // 그림자 색상 설정
            child: Stack(
              children: [
                // 배경 이미지
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'lib/assets/images/collection_card.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                // 좌상단 텍스트
                Positioned(
                  top: 15,
                  left: 15,
                  child: Text(
                    '컬렉션\n확인하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                highlightColor: primaryColorLight.withAlpha(50),
                onTap: () {
                  Navigator.pushNamed(context,'/collectionHome');
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MissionProgressCard extends StatelessWidget {
  final String title;
  final int current;
  final int total;

  const MissionProgressCard({
    Key? key,
    required this.title,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // 진행 바
            for (int i = 0; i < total; i++)
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i != total - 1 ? 8.0 : 0),
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: i < current
                      ? const LinearGradient(
                        colors: [Color(0xFF4C6EF5), Color(0xFFB197FC)],
                      )
                      : null,
                    color: i < current ? null : Colors.white,
                    border: Border.all(color: const Color(0xFF4C6EF5), width: 1),
                    boxShadow: i < current
                      ? [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ]
                      : [],
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Text('$current/$total'),
          ],
        ),
      ],
    );
  }
}
