import 'package:flutter/material.dart';
import 'pages/collection_page.dart';
import 'pages/ranking_page.dart';
import 'pages/camera_page.dart';
import 'main_page.dart';
import 'package:bremen/themes.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page App',
      theme: AppTheme.lightTheme(context),
      home: MainPage(),
    );
  }
}