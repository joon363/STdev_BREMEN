import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stdev_bremen/screens/CollectionDetail.dart';
import 'package:stdev_bremen/models/card_item.dart';
import 'package:stdev_bremen/constants/card_styles.dart';
import 'package:stdev_bremen/themes.dart';
export 'package:provider/provider.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late Future<List<CardItem>> _futureItems;
  @override
  void initState() {
    super.initState();
    _futureItems = fetchNoCardItems(); // 서버에서 받아오는 함수
  }
  Future<List<CardItem>> fetchNoCardItems() async {
    await Future.delayed(const Duration(seconds: 1)); // 3초 대기 (서버 응답 시뮬레이션)
    return [];
  }
  Future<List<CardItem>> fetchCardItems() async {
    await Future.delayed(const Duration(seconds: 1)); // 3초 대기 (서버 응답 시뮬레이션)
    return [
      CardItem(
        name: "자석의 극",
        imagePath: "assets/images/magnet_pole.png",
        isUnlocked: true,
        rarity: Rarity.common,
        description:
        "자석에는 N극과 S극이 있으며, 같은 극끼리는 밀어내고 다른 극끼리는 끌어당기는 성질이 있습니다.",
      ),
      CardItem(
        name: "자석의 작용 범위",
        imagePath: "assets/images/magnet_range.png",
        isUnlocked: false,
        rarity: Rarity.rare,
        description:
        "자석은 닿지 않아도 가까운 곳에 있는 철 물체를 끌어당길 수 있습니다. 이 범위를 자력이라고 합니다.",
      ),
      CardItem(
        name: "자석의 작용 범위",
        imagePath: "assets/images/magnet_range.png",
        isUnlocked: true,
        rarity: Rarity.rare,
        description:
        "자석은 닿지 않아도 가까운 곳에 있는 철 물체를 끌어당길 수 있습니다. 이 범위를 자력이라고 합니다.",
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("분석 결과")),
      body: SafeArea(
        child:
        Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        width: double.maxFinite,
                        height: 320,
                        fit: BoxFit.cover,
                        File(widget.imagePath)
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Text(
                      '획득한 카드',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FutureBuilder<List<CardItem>>(
                    future: _futureItems,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 로딩 중일 때
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // 에러 처리
                        return Center(child: Text('에러 발생: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // 데이터 없을 때
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '획득한 카드가 없어요. 다시 찍어 보세요!',
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        );
                      }
                      final items = snapshot.data!;
                      return Column(
                        spacing: 10,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:
                            Row(
                              mainAxisAlignment: items.length == 1
                                ? MainAxisAlignment.center // 하나일 때 가운데 정렬
                                : MainAxisAlignment.start,  // 여러 개면 왼쪽 정렬
                              children: items.map((item) {
                                  return SizedBox(
                                    width: 150,
                                    height: 120,
                                    child: CollectionCard(item: item),
                                  );
                                }).toList(),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(16),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [primaryColor, secondaryColorLight],
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('✨'),
                                  Text(
                                    '오늘 해결할 호기심에 해당하는 영역!\n좋아 더 찾아보자고~!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('✨'),
                                ],
                              )
                            ),
                          )
                        ],
                      );
                    },
                  )

                ],
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(16),
                      color: primaryColorLight,
                    elevation: 5,

                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,'/chatbot');
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '궁금한게 있으면 더 물어봐!',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        )
                    )
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        width: 130,
                        height: 130,
                        fit: BoxFit.fitHeight,
                        'lib/assets/images/onboarding_transparent.png',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}
