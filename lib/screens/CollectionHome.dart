import 'package:flutter/material.dart';

class CollectionHomePage extends StatefulWidget {
  const CollectionHomePage({super.key});

  @override
  State<CollectionHomePage> createState() => _CollectionHomePageState();
}

class _CollectionHomePageState extends State<CollectionHomePage> {
  final List<Collection> collections = [
    const Collection(id: "초3_물리", title: "초등 3학년 물리", subscribers: 1200, progress: 0.45),
    const Collection(id: "중등_화학", title: "중등 화학 기본", subscribers: 800, progress: 0.7),
    const Collection(id: "탐구", title: "과학 탐구생활", subscribers: 300, progress: 0.1),
  ];

  Future<void> _goToCreatePage() async {
    final result = await Navigator.pushNamed(context, '/createCollection');
    if (result is Map<String, dynamic>) {
      setState(() {
        collections.add(Collection(
          id: result['id'],
          title: result['title'],
          subscribers: result['subscribers'],
          progress: result['progress'],
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("나의 과학 컬렉션")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "컬렉션 검색",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _goToCreatePage,
                icon: const Icon(Icons.add),
                label: const Text("새 컬렉션 만들기"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final collection = collections[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/collectionDetail',
                        arguments: {'collectionKey': collection.id},
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(collection.title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text("가입자 ${collection.subscribers}명"),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(value: collection.progress),
                            const SizedBox(height: 4),
                            Text("진행률 ${(collection.progress * 100).toStringAsFixed(1)}%"),
                          ],
                        ),
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
  final String id; // 🔑 !!!collectionKey 역할!!!
  final String title;
  final int subscribers;
  final double progress;

  const Collection({
    required this.id,
    required this.title,
    required this.subscribers,
    required this.progress,
  });
}