import 'package:flutter/material.dart';

import 'game_engine.dart';
import 'square_field.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.uiState,
    required this.onMove,
  });

  final UiState uiState;
  final MoveCallback onMove;

  String get gameStatusMessage {
    switch (uiState.currentTurn) {
      case Player.dash:
        return 'Dash is thinking...';
      case Player.human:
        return 'Dash is waiting for your move!';
      case null:
        switch (uiState.winner) {
          case Player.dash:
            return 'Game Over! Dash won.';
          case Player.human:
            return 'Congratulations! You won.';
          case null:
            return "Game Over! It's a tie!";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: SquareField(
            uiState: uiState,
            onMove: onMove,
          ),
        ),
        Center(
          child: Text(
            gameStatusMessage,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
