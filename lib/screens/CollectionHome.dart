import 'package:flutter/material.dart';
import '../models/card_item.dart';
import 'CollectionDetail.dart';

class CollectionHomePage extends StatefulWidget {
  const CollectionHomePage({super.key});

  @override
  State<CollectionHomePage> createState() => _CollectionHomePageState();
}

const purple = Color(0xFF0E06ED);
const purpleGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF0E06ED), Color(0xFFA69EEF)],
);

class _CollectionHomePageState extends State<CollectionHomePage> {
  final List<Collection> collections = [
    const Collection(id: "중3_물리", title: "중등 3학년 물리", subscribers: 1200, progress: 0.55, image: 'lib/assets/icons/microbe.png'),
    const Collection(id: "중등_화학", title: "중등 화학 기본", subscribers: 520, progress: 0.9, image: 'lib/assets/icons/flask.png'),
    const Collection(id: "중2_생명", title: "중등 2학년 생명과학", subscribers: 2000, progress: 0.2, image: 'lib/assets/icons/germ.png'),
    const Collection(id: "중2_지구", title: "중등 지구과학 기본", subscribers: 150, progress: 0.3, image: 'lib/assets/icons/earth.png'),
  ];
  final Map<String, Map<String, List<CardItem>>> customCollectionData = {};

  Future<void> _goToCreatePage() async {
    final result = await Navigator.pushNamed(context, '/createCollection');

    if (result is Map<String, dynamic>) {
      setState(() {
        // 리스트에 새 컬렉션 추가
        collections.add(Collection(
          id: result['id'],
          title: result['title'],
          subscribers: result['subscribers'] ?? 0,
          progress: result['progress'] ?? 0.0,
          image: result['image'] ?? 'lib/assets/icons/microbe.png',
        ));

        // 상세 데이터 저장
        customCollectionData[result['id']] = (result['data'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, (value as List).cast<CardItem>()));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 타이틀 및 검색창
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.arrow_back_ios_new, color: purple, size: 30),
                      SizedBox(width: 8),
                      Baseline(
                        baseline: 40,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "나의 ",
                          style: TextStyle(
                            fontFamily: 'Kakao',
                            fontWeight: FontWeight.normal,
                            fontSize: 34,
                            color: purple,
                          ),
                        ),
                      ),
                      Text(
                        "과학 컬렉션",
                        style: TextStyle(
                          fontFamily: 'Kakao',
                          fontWeight: FontWeight.normal,
                          fontSize: 40,
                          color: purple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16), // 여백 확보
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: purpleGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15), // 더 진하게
                          blurRadius: 10,
                          offset: const Offset(0, 4), // 더 아래로 그림자
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 16),
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "컬렉션 검색",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Kakao'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white, size: 30),
                          onPressed: _goToCreatePage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final collection = collections[index];
                  return GestureDetector(
                    onTap: () {
                      if (customCollectionData.containsKey(collection.id)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollectionDetailPage(
                              title: collection.title,
                              data: customCollectionData[collection.id],
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/collectionDetail',
                          arguments: {'collectionKey': collection.id},
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 155,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    collection.title,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Kakao'),
                                  ),
                                  const SizedBox(height: 0),
                                  Text("가입자 ${collection.subscribers}명", style: const TextStyle(fontFamily: 'Kakao', fontSize: 13)),
                                  const SizedBox(height: 24),
                                  Text("진행률 ${(collection.progress * 100).toStringAsFixed(0)}%", style: const TextStyle(fontFamily: 'Kakao', fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Stack(
                                    children: [
                                      // 배경 바
                                      Container(
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12.withOpacity(0.15),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 진행 바
                                      Container(
                                        height: 26,
                                        width: MediaQuery.of(context).size.width * 0.45 * collection.progress,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xFF8F8CFF), Colors.white],
                                          ),
                                          border: Border.all(
                                            color: Colors.white, // 테두리 색상
                                            width: 1,
                                            ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                collection.image,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Collection {
  final String id;
  final String title;
  final int subscribers;
  final double progress;
  final String image;

  const Collection({
    required this.id,
    required this.title,
    required this.subscribers,
    required this.progress,
    required this.image,
  });
}