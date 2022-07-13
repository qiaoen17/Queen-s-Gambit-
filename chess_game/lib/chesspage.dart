import 'dart:math';

import 'package:chess_game/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

import 'utils.dart';


class chessPage extends StatefulWidget {
  @override
  chessPageState createState() => chessPageState();
}

class chessPageState extends State<chessPage> {
  String fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  
  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    final size = min(viewport.height, viewport.width);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar (
        title: const Text("Queen's Gambit"),
      ),
      body: Center(
        child: Chessboard(
          fen: fen,
          size: size,
          buildSquare: (color, size) {
            return Container(
              width: size,
              height: size,
              color:
                color == BoardColor.WHITE ? Colors.brown : Color.fromARGB(255, 206, 148, 127),
            );
          },
          orientation: BoardColor.BLACK,
          buildPiece: (piece, size) {
            if (piece == Piece.WHITE_PAWN) {
              return Icon(
                Icons.person,
                size: size,
                color: Colors.white,
              );
            } else if (piece == Piece.BLACK_PAWN) {
              return Icon(
                Icons.person,
                size: size,
                color: Colors.black,
              );
            }
          },
          onPromote: () {
            return showDialog<PieceType>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Promotion'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Queen'),
                        onTap: () => navigator.pop(PieceType.QUEEN),
                      ),
                      ListTile(
                        title: const Text('Rook'),
                        onTap: () => navigator.pop(PieceType.BISHOP),
                      ),
                      ListTile(
                        title: const Text('Knight'),
                        onTap: () => navigator.pop(PieceType.KNIGHT),
                      ),
                      ListTile(
                        title: const Text("Bishop"),
                        onTap: () => navigator.pop(PieceType.BISHOP),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          onMove: (move) {
            final nextFen = makeMove(fen, {
              'from': move.from,
              'to': move.to,
              'promotion':
                  move.promotion.map((t) => t.toString()).getOrElse(() => "q"),
            });

            if (nextFen != null) {
              setState(() {
                fen = nextFen;
              });

              Future.delayed(const Duration(milliseconds: 100)).then((_) {
                final computerMove = getRandomMove(fen);
                final computerFen = makeMove(fen, computerMove);

                if (computerMove != null && computerFen != null) {
                  setState(() {
                    fen = computerFen;
                  });
                }

                if (computerMove == null) {
                  setState(() {
                    fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                );
                  });
                }
              });
            }
          },
        ),
      ),
    );
  }
}