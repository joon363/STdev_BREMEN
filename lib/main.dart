import 'package:flutter/material.dart';
import 'package:stdev_bremen/pages/camera_page.dart';
import 'package:stdev_bremen/pages/ranking_page.dart';
import 'package:stdev_bremen/screens/CollectionHome.dart';
import 'main_page.dart';
import 'package:stdev_bremen/themes.dart';
import 'package:stdev_bremen/pages/onboarding_page.dart';
import 'screens/CollectionDetail.dart';
import 'screens/CardDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme(context),
      title: 'STdev Collection App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/main': (context) => MainPage(),
        '/camera': (context) => CameraPage(),
        '/ranking': (context) => RankingPage(),
        '/collectionHome': (context) => CollectionHomePage(),
        '/cardDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CardDetailPage(card: args['card']);
        },
      },
    );
  }
}
