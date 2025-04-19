import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

const LinearGradient purpleGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF0E06ED),
    Color(0xFFA69EEF),
  ],
);

const purple = Color(0xFF0E06ED);

class _RankingPageState extends State<RankingPage> with SingleTickerProviderStateMixin {
  bool isCollectionLeague = true;
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void toggleSwitch(bool toCollection) {
    setState(() {
      isCollectionLeague = toCollection;
      if (toCollection) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  Widget _buildRankItem({
    required String rankAsset,
    required String nickname,
    required int cards,
    bool isFirst = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: Image.asset(
              rankAsset,
              fit: BoxFit.contain,
              height: isFirst ? 78 : 47,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nickname,
                      style: TextStyle(
                        fontFamily: 'Kakao',
                        fontSize: isFirst ? 24 : 20,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'lib/assets/icons/card_icon.png',
                      height: isFirst ? 28 : 24,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$cards장',
                      style: const TextStyle(
                        fontFamily: 'Kakao',
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      layoutBuilder: (currentChild, previousChildren) => currentChild!,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: isCollectionLeague ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      child: isCollectionLeague
          ? _buildCollectionLeague()
          : _buildMembershipLeague(),
    );
  }

  Widget _buildCollectionLeague() {
    return Column(
      key: const ValueKey('collection'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "중등 3학년 물리 랭킹",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: purple,
                fontFamily: 'Kakao',
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'lib/assets/icons/trophy.png',
              height: 38,
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          "4월 2주차 결과 발표",
          style: TextStyle(fontSize: 20, color: purple, fontFamily: 'Kakao'),
        ),
        const SizedBox(height: 10),
        // 모은 호기심 카드 버튼
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/collectionDetail', arguments: {
              'collectionKey': '중등_화학',
              'title': '중등 화학 기본',
            });
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: purpleGradient,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "모은 호기심 카드",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white, fontFamily: 'Kakao',),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildRankCard([
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_1.png', nickname: '브레멘', cards: 42, isFirst: true),
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_2.png', nickname: '죽음의 드러머', cards: 35),
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_3.png', nickname: '코트보베인', cards: 21),
        ]),
        const SizedBox(height: 20),
        Row(
          children: [
            const Text(
              "중등 화학 기본",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: purple,
                fontFamily: 'Kakao',
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'lib/assets/icons/trophy.png',
              height: 38,
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          "4월 2주차 결과 발표",
          style: TextStyle(fontSize: 20, color: purple, fontFamily: 'Kakao'),
        ),
        const SizedBox(height: 10),
        // 모은 호기심 카드 버튼
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/collectionDetail', arguments: {
              'collectionKey': '중등_화학',
              'title': '중등 화학 기본',
            });
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: purpleGradient,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "모은 호기심 카드",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white, fontFamily: 'Kakao',),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildRankCard([
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_1.png', nickname: '포닉스', cards: 42, isFirst: true),
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_2.png', nickname: '넙죽이', cards: 35),
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_3.png', nickname: '푸앙이', cards: 21),
        ]),
      ],
    );
  }

  Widget _buildMembershipLeague() {
    return Column(
      key: const ValueKey('membership'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "멤버십 특별 랭킹",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: purple,
                fontFamily: 'Kakao',
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'lib/assets/icons/trophy.png',
              height: 38,
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          "4월 2주차 기준",
          style: TextStyle(fontSize: 20, color: purple, fontFamily: 'Kakao'),
        ),
        const SizedBox(height: 10),
        _buildRankCard([
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_1.png', nickname: '회원1', cards: 50, isFirst: true),
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_2.png', nickname: '회원2', cards: 40),
          _buildRankItem(rankAsset: 'lib/assets/icons/rank_3.png', nickname: '회원3', cards: 30),
        ]),
      ],
    );
  }

  Widget _buildRankCard(List<Widget> ranks) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: purpleGradient,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: ranks,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: purpleGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 상단 고정 영역
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_back_ios_new, color: purple, size: 30),
                        const SizedBox(width: 8),
                        const Baseline(
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
                        const Text(
                          "호기심 랭킹",
                          style: TextStyle(
                            fontFamily: 'Kakao',
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                            color: purple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: purpleGradient,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Align(
                                alignment: _animation.value,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 - 32,
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                              );
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => toggleSwitch(true),
                                  child: Center(
                                    child: Text(
                                      '컬렉션 리그',
                                      style: TextStyle(
                                        fontFamily: 'Kakao',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: isCollectionLeague ? Colors.black : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => toggleSwitch(false),
                                  child: Center(
                                    child: Text(
                                      '멤버십 리그',
                                      style: TextStyle(
                                        fontFamily: 'Kakao',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: isCollectionLeague ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: _buildLeagueContent(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}