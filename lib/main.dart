import 'package:flutter/material.dart';
import 'screens/CollectionHome.dart';
import 'screens/CollectionDetail.dart';
import 'screens/CardDetail.dart';
import 'screens/CreateCollectionPage.dart'; // ✅ 새로 추가된 페이지 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STdev Collection App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CollectionHomePage(),
        '/collectionDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CollectionDetailPage(collectionKey: args['collectionKey']);
        },
        '/cardDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CardDetailPage(card: args['card']);
        },
        '/createCollection': (context) => const CreateCollectionPage(),
      },
    );
  }
}
