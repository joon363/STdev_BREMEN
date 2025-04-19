import 'package:flutter/material.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<Widget> contentBlocks = []; // 커리큘럼 제목/카드 위젯 리스트

  void _addBlock() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.title),
              title: const Text('커리큘럼 제목 추가'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  contentBlocks.add(_buildCurriculumTitle());
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_module),
              title: const Text('카드 추가'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  contentBlocks.add(_buildCardEditor());
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: const [
          Icon(Icons.drag_handle),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: '커리큘럼 제목',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardEditor() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.drag_handle),
              SizedBox(width: 8),
              Text('카드')
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('이미지 업로드'),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '카드 제목',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              labelText: '카드 설명',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("컬렉션 만들기")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "컬렉션 제목",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "컬렉션 설명",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Column(children: contentBlocks),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _addBlock,
                icon: const Icon(Icons.add),
                label: const Text("항목 추가"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("제목을 입력하세요.")),
                    );
                    return;
                  }

                  Navigator.pop(context, {
                    'id': titleController.text, // 임시 ID는 제목으로
                    'title': titleController.text,
                    'subscribers': 0,
                    'progress': 0.0,
                  });
                },
                child: const Text("컬렉션 생성 완료"),
              )
            ],
          ),
        ),
      ),
    );
  }
}