import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'dash.dart';
import 'game_board.dart';
import 'game_engine.dart';
import 'lobby.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  GameEngine? _engine;
  UiState? uiState;

  final ConfettiController controller = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  Future<void> startGame(GameEngine engine) async {
    setState(() {
      _engine = engine;
    });
    final UiState state = await _engine!.start();
    setState(() {
      uiState = state;
    });
  }

  Future<void> reportMove(int row, int col) async {
    UiState state = await _engine!.reportMove(row, col);
    setState(() {
      uiState = state;
    });
    if (!state.gameOver) {
      // Ask Dash to make the next move.
      state = await _engine!.makeMove();
      setState(() {
        uiState = state;
      });
    } else if (state.winner == Player.human) {
      controller.play();
    }
  }

  void reset() {
    setState(() {
      _engine?.dispose();
      _engine = null;
      uiState = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: controller,
      blastDirectionality: BlastDirectionality.explosive,
      maxBlastForce: 100,
      emissionFrequency: 0.05,
      numberOfParticles: 50,
      gravity: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dish Dash Doe'),
          actions: [
            IconButton(
              onPressed: reset,
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Dash(
                dancing: _engine != null && uiState?.gameOver != true,
              ),
            ),
            Flexible(
              flex: 32,
              child: SizedBox(
                width: 340,
                child: Center(
                  child: _engine == null
                      ? Lobby(onStartGame: startGame)
                      : uiState != null
                          ? GameBoard(uiState: uiState!, onMove: reportMove)
                          : const Text('Loading...'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
