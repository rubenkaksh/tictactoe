import 'package:flutter/material.dart';

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<List<String>> board = List.generate(
      3, (_) => List.generate(3, (_) => '')); // Initialize 3x3 matrix as empty
  String currentPlayer = 'X';

  void _handleTap(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        board[row][col] = currentPlayer;
        if (_checkForWinner()) {
          // Handle winner
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Winner!'),
                content: Text('$currentPlayer wins!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        board = List.generate(3,
                            (_) => List.generate(3, (_) => '')); // Reset board
                      });
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else if (_isBoardFull()) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Draw!'),
                content: Text('The game is a draw!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        board = List.generate(3,
                            (_) => List.generate(3, (_) => '')); // Reset board
                      });
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _isBoardFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell == '') return false;
      }
    }
    return true;
  }

  bool _checkForWinner() {
    // Check rows and columns using the pattern
    for (int i = 0; i < 3; i++) {
      // Check row pattern (i,0), (i,1), (i,2)
      if (board[i][0] != '' &&
          board[i][0] == board[i][1] &&
          board[i][0] == board[i][2]) {
        return true;
      }

      // Check column pattern (0,i), (1,i), (2,i)
      if (board[0][i] != '' &&
          board[0][i] == board[1][i] &&
          board[0][i] == board[2][i]) {
        return true;
      }
    }

    // Check diagonal patterns
    // Pattern 1: (0,0), (1,1), (2,2)
    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[0][0] == board[2][2]) {
      return true;
    }

    // Pattern 2: (0,2), (1,1), (2,0)
    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[0][2] == board[2][0]) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Player: $currentPlayer',
              style: TextStyle(fontSize: 20),
            ),
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int j = 0; j < 3; j++) _buildSquare(i, j),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquare(int row, int col) {
    return GestureDetector(
      onTap: () => _handleTap(row, col),
      child: Container(
        width: 80.0,
        height: 80.0,
        child: Center(
            child: Text(board[row][col], style: TextStyle(fontSize: 24.0))),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
        ),
      ),
    );
  }
}
