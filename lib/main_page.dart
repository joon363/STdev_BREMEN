import 'package:flutter/material.dart';
import 'screens/CollectionHome.dart';
import 'pages/ranking_page.dart';
import 'pages/camera_page.dart';

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
            children: [
              // ✅ 일일 미션
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "일일 미션",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _missions[index]
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.deepPurple,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "미션 ${index + 1}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );


                }),
              ),
              SizedBox(height: 20),

              // ✅ 컬렉션 / 랭킹 버튼 (가로 배치)
              // ✅ 컬렉션 / 랭킹 버튼 (가로 배치 + 높이 조절)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 120, // 높이 지정
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.collections, size: 32),
                        label: Text("컬렉션", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CollectionHomePage()),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 120, // 높이 지정
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.leaderboard, size: 32),
                        label: Text("랭킹", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RankingPage()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),

      // ✅ 하단 카메라 + 양옆 아이콘
      bottomNavigationBar: BottomAppBar(
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
                  icon: Icon(Icons.more_horiz, size:30),
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
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Scaffold 내의 floatingActionButton 자리에 넣기
      floatingActionButton: Material(
        color: Colors.deepPurple,
        shape: const CircleBorder(),
        elevation: 6,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CameraPage()),
            );
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
      ),
    );
  }
}
