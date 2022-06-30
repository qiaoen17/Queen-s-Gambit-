import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';

import 'utils.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  
  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    final size = min(viewport.height, viewport.width);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar (
        title: Text("Queen's Gambit"),
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
                  title: Text('Promotion'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('Queen'),
                        onTap: () => navigator.pop(PieceType.QUEEN),
                      ),
                      ListTile(
                        title: Text('Rook'),
                        onTap: () => navigator.pop(PieceType.BISHOP),
                      ),
                      ListTile(
                        title: Text('Knight'),
                        onTap: () => navigator.pop(PieceType.KNIGHT),
                      ),
                      ListTile(
                        title: Text("Bishop"),
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

              Future.delayed(Duration(milliseconds: 300)).then((_) {
                final computerMove = getRandomMove(fen);
                final computerFen = makeMove(fen, computerMove);

                if (computerMove != null && computerFen != null) {
                  setState(() {
                    fen = computerFen;
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