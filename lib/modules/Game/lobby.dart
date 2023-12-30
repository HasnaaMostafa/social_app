import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'concurrent_game_engine.dart';
import 'game_engine.dart';

typedef StartGameCallback = void Function(GameEngine engine);

class Lobby extends StatelessWidget {
  const Lobby({super.key, required this.onStartGame});

  final StartGameCallback onStartGame;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //serial
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade300)),
          child: Text(
            'Sync Engine',
            style: TextStyle(color: HexColor("#B7950B")),
          ),
          onPressed: () {
            onStartGame(GameEngine());
          },
        ),
        const SizedBox(height: 20),
        // parallel
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade300)),
          child: Text(
            'Isolate Engine',
            style: TextStyle(color: HexColor("#B7950B")),
          ),
          onPressed: () {
            onStartGame(ConcurrentGameEngine());
          },
        ),
      ],
    );
  }
}
