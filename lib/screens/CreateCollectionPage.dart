import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<_BlockEntry> contentEntries = [];

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
                final controller = TextEditingController();
                final widget = _buildCurriculumTitle(controller);
                setState(() {
                  contentEntries.add(_BlockEntry.section(widget, controller));
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_module),
              title: const Text('카드 추가'),
              onTap: () {
                Navigator.pop(context);
                final titleController = TextEditingController();
                final descController = TextEditingController();
                final rarity = Rarity.common;
                final widget = _buildCardEditor(titleController, descController);
                final input = _CardInput(
                  titleController: titleController,
                  descController: descController,
                  rarity: rarity,
                );
                setState(() {
                  contentEntries.add(_BlockEntry.card(widget, input));
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumTitle(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.drag_handle),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '커리큘럼 제목',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardEditor(TextEditingController titleCtrl, TextEditingController descCtrl) {
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
              Expanded(
                child: TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: '카드 제목',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descCtrl,
            decoration: const InputDecoration(
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
              Column(children: contentEntries.map((e) => e.widget).toList()),
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

                  final Map<String, List<Map<String, dynamic>>> resultData = {};
                  String currentSection = '기본 주제';

                  for (final entry in contentEntries) {
                    if (entry.isSection) {
                      final text = entry.sectionController?.text.trim() ?? '';
                      currentSection = text.isNotEmpty ? text : '기본 주제';
                    } else if (entry.cardInput != null) {
                      final input = entry.cardInput!;
                      resultData.putIfAbsent(currentSection, () => []).add({
                        'name': input.titleController.text,
                        'description': input.descController.text,
                        'imagePath': 'assets/images/placeholder.png',
                        'isUnlocked': true,
                        'rarity': input.rarity.name,
                      });
                    }
                  }

                  Navigator.pop(context, {
                    'id': titleController.text,
                    'title': titleController.text,
                    'subscribers': 0,
                    'progress': 0.0,
                    'data': resultData.map((key, list) => MapEntry(
                      key,
                      list.map((e) => CardItem(
                        name: e['name'],
                        description: e['description'],
                        imagePath: e['imagePath'],
                        isUnlocked: e['isUnlocked'],
                        rarity: Rarity.values.firstWhere(
                              (r) => r.name == e['rarity'],
                          orElse: () => Rarity.common,
                        ),
                      )).toList(),
                    )),
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

class _BlockEntry {
  final Widget widget;
  final bool isSection;
  final TextEditingController? sectionController;
  final _CardInput? cardInput;

  _BlockEntry.section(this.widget, this.sectionController)
      : isSection = true,
        cardInput = null;

  _BlockEntry.card(this.widget, this.cardInput)
      : isSection = false,
        sectionController = null;
}

class _CardInput {
  final TextEditingController titleController;
  final TextEditingController descController;
  final Rarity rarity;

  _CardInput({
    required this.titleController,
    required this.descController,
    required this.rarity,
  });
}
