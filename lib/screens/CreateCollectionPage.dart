import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../constants/card_styles.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

const purple = Color(0xFF0E06ED);
const purpleGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF0E06ED), Color(0xFFA69EEF)],
);

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumTitle(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: purpleGradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '| 커리큘럼 제목',
          hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildCardEditor(TextEditingController titleCtrl, TextEditingController descCtrl) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '카드 생성하기',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: purple),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // 이미지 첨부 버튼 (그라디언트 + 그림자)
              Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0E06ED), Color(0xFFA69EEF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    // TODO: 이미지 첨부 기능
                  },
                  child: const Text(
                    '이미지 첨부',
                    style: TextStyle(
                      fontFamily: 'Kakao',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // 카드 제목 입력 필드 (둥근 테두리 + 그림자)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      hintText: '| 카드 제목',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: '| 카드 설명',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new, size: 30, color: purple),
                    ),
                    const SizedBox(width: 8),
                    const Text('컬렉션 만들기', style: TextStyle(fontSize: 32, color: purple, fontFamily: 'Kakao')),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    gradient: purpleGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '| 컬렉션 제목',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '| 컬렉션 설명',
                    ),
                    maxLines: 4,
                  ),
                ),
                const SizedBox(height: 24),
                Column(children: contentEntries.map((e) => e.widget).toList()),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: _addBlock,
                      icon: const Icon(Icons.add, color: purple),
                      label: const Text('항목 추가하기', style: TextStyle(color: purple)),
                    ),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                      child: const Text("컬렉션 생성 완료", style: TextStyle(fontSize: 16)),
                    )
                  ],
                ),
              ],
            ),
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
