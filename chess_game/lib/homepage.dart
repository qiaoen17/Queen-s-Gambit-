import 'package:chess_game/ChessPage.dart';
import 'package:flutter/material.dart';

import 'ChessPage.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queen's Gambit"),
      ),
      body: SafeArea(
        child: ElevatedButton(
          child: const Text('Start Game'),
          onPressed: () {
          // Navigate to the chess game page 
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => chessPage()),
            );
          },
          ),
        ),

    );
  }
}