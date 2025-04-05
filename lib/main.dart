import 'package:flutter/material.dart';
import 'package:tictactoe/draggable.dart';
import 'package:tictactoe/tictactoe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToePage(),
    );
  }
}