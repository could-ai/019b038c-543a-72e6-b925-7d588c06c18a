import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  // The 3x3 board is represented by a list of 9 strings
  List<String> _board = List.filled(9, '');
  
  // Current player: 'X' or 'O'
  String _currentPlayer = 'X';
  
  // Game state variables
  String _winner = '';
  bool _isDraw = false;

  // Handle a cell tap
  void _handleTap(int index) {
    // If cell is already filled or game is over, do nothing
    if (_board[index] != '' || _winner != '') return;

    setState(() {
      _board[index] = _currentPlayer;
      
      if (_checkWinner(_currentPlayer)) {
        _winner = _currentPlayer;
      } else if (!_board.contains('')) {
        _isDraw = true;
      } else {
        // Switch player
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  // Check all winning combinations
  bool _checkWinner(String player) {
    const winningLines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]             // Diagonals
    ];

    for (var line in winningLines) {
      if (_board[line[0]] == player &&
          _board[line[1]] == player &&
          _board[line[2]] == player) {
        return true;
      }
    }
    return false;
  }

  // Reset the game to initial state
  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
      _isDraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Status Display
              _buildStatusText(),
              const SizedBox(height: 20),
              
              // Game Grid
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return _buildGridItem(index);
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Restart Button
              ElevatedButton.icon(
                onPressed: _resetGame,
                icon: const Icon(Icons.refresh),
                label: const Text('Restart Game'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    String text;
    Color color;

    if (_winner.isNotEmpty) {
      text = 'Player $_winner Wins!';
      color = Colors.green;
    } else if (_isDraw) {
      text = 'It\'s a Draw!';
      color = Colors.orange;
    } else {
      text = 'Current Player: $_currentPlayer';
      color = Theme.of(context).colorScheme.primary;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            _board[index],
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _board[index] == 'X' 
                  ? Colors.blue 
                  : (_board[index] == 'O' ? Colors.red : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
