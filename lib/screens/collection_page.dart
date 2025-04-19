import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("컬렉션")),
      body: Center(child: Text("컬렉션 페이지")),
    );
  }
}
