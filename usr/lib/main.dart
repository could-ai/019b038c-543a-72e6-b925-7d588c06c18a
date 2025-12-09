import 'package:flutter/material.dart';
import 'tic_tac_toe_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Explicitly defining the initial route and routes map is best practice
      initialRoute: '/',
      routes: {
        '/': (context) => const TicTacToeGame(),
      },
    );
  }
}
