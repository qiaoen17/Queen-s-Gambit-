import 'package:flutter/material.dart';

import 'chesspage.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Queen's Gambit",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}

