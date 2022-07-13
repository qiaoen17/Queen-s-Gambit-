import 'package:chess_game/ChessPage.dart';
import 'package:flutter/material.dart';

import 'ChessPage.dart';
import 'HomePage.dart';

class GameOver extends StatelessWidget {

  const GameOver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queen's Gambit"),
      ),
      body: Row(
        children: <Widget>[
          Center(
          child: ElevatedButton(
            child: const Text('Home'),
            onPressed: () {
            // Navigate to the chess game page 
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          ),
        ),
        Center(
          child: ElevatedButton(
            child: const Text('Play Again'),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => chessPage()),
              );
            },
          ),
        ),
        SizedBox.fromSize(
          size: const Size(56, 56),
          child: ClipOval(
            child: Material(
              color: Colors.amberAccent,
              child: InkWell(
                splashColor: Colors.green,
                onTap: () {},
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.home),
                  ],
                )
              )
            )
          ),
        )
        ]
      )  
      );
  }
}