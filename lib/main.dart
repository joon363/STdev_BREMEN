import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:stdev_bremen/themes.dart';
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
        '/': (context) => MainPage(),
        '/collectionDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CollectionDetailPage(title: args['title']);
        },
        '/cardDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CardDetailPage(card: args['card']);
        },
      },
    );
  }
}
