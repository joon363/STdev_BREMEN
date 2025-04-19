import 'package:flutter/material.dart';
import 'package:stdev_bremen/themes.dart';
import 'package:stdev_bremen/main_page.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // 3초 후 자동 이동
    Timer(const Duration(seconds: 3), _goToNextPage);
  }

  void _goToNextPage() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final curve = Curves.easeInOut; // 부드러운 효과

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _goToNextPage,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 상단 타이틀
              Expanded(flex: 2, child: Container()),
              Expanded(flex: 4, child:
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '사이언스냅',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),),
              Expanded(flex: 10, child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/onboarding_transparent.png',
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        'lib/assets/images/onboarding_balls.png',
                      ),),
                  ],
                ),),
              Expanded(flex: 1, child: Container()),
              Expanded(flex: 1, child: Container()),

              // 중간 겹친 이미지

              // 하단 버튼

            ],
          ),
        ),
      )
    );
  }
}
