import 'package:flutter/material.dart';
import 'CollectionDetail.dart';

class CollectionHomePage extends StatelessWidget {
  const CollectionHomePage({super.key});

  final List<Collection> collections = const [
    Collection("초등 3학년 물리", 1200, 0.45),
    Collection("중등 화학 기본", 800, 0.7),
    Collection("과학 탐구생활", 300, 0.1),
  ];

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
                        arguments: {'title': collection.title},
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
  final String title;
  final int subscribers;
  final double progress;

  const Collection(this.title, this.subscribers, this.progress);
}
