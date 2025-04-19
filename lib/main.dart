import 'package:flutter/material.dart';
import 'package:stdev_bremen/pages/camera_page.dart';
import 'package:stdev_bremen/pages/camera_simple_page.dart';
import 'package:stdev_bremen/screens/CollectionHome.dart';
import 'main_page.dart';
import 'package:stdev_bremen/themes.dart';
import 'package:stdev_bremen/pages/onboarding_page.dart';
import 'package:stdev_bremen/pages/chatbot_page.dart';
import 'screens/CollectionDetail.dart';
import 'screens/CardDetail.dart';
import 'screens/CreateCollectionPage.dart';
import 'screens/RankingPage.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 카메라 리스트 가져오기
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

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
        '/cameraTest': (context) => CameraTestPage(),
        '/camera': (context) => CameraPage(camera: camera),
        '/chatbot': (context) => ChatBotPage(),
        '/ranking': (context) => RankingPage(),
        '/collectionHome': (context) => CollectionHomePage(),
        '/cardDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CardDetailPage(card: args['card']);
        },
        '/collectionDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CollectionDetailPage(collectionKey: args['collectionKey']);
        },
        '/createCollection': (context) => const CreateCollectionPage(),
      },
    );
  }
}
