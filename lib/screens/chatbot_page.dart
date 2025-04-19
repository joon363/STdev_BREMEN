import 'package:flutter/material.dart';
import 'package:stdev_bremen/themes.dart';
class ChatMessage {
  final String text;
  final bool isUser;
  final bool isLoading;

  ChatMessage({required this.text, required this.isUser, this.isLoading = false});
}
class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _messages.add(ChatMessage(text: '', isUser: false, isLoading: true));
    });

    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.removeLast(); // remove loading
        _messages.add(ChatMessage(
          text: '''좋은 질문이야! 🙌

소금이나 설탕을 얼음에 뿌리면 얼음이 
더 빨리 녹는 현상이 일어나.

 그 이유는 얼음의 녹는점을 낮추기 때문이야.

🧂 왜 그런 일이 생길까?
물질이 얼음 위에 놓이면,
 → 얼음 표면의 물과 섞이게 돼
 → 이 혼합물은 순수한 물보다 낮은 온도에서 녹게 돼
 → 그래서 녹는점이 내려가고, 얼음은 주변 온도보다 더
 쉽게 녹는 거야!

🧪 예를 들어 볼까?
소금은 겨울철 도로에 뿌리면 빙판이 녹는 데 사용돼
 → 이유: 소금물은 0도보다 낮은 온도에서도 액체 상태를 유지하기 때문!
설탕도 같은 원리지만, 소금보다 효과는 좀 덜해
 → 그래도 녹는점을 낮추는 작용은 해

❄ 이걸 과학적으로 뭐라고 할까?
이런 현상은 '빙점 강하' 또는 '어는점 내림 현상'이라고 불러
 → '용질(소금, 설탕)'이 물에 녹을 때,
 → 그 용액은 원래보다 더 낮은 온도에서 얼게 돼''',
          isUser: false,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Stack(
              alignment: Alignment.bottomRight,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColorLight
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
              ]
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? Colors.tealAccent.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: msg.isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Text(
                      msg.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "메시지를 입력하세요...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),)
    );
  }
}