import 'dart:math';

import 'package:thousand_bombs_grenades/game/game.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

void main(List<String> arguments) {
  final random = Random(1);

  final players = [
    Player("Player 1"),
    Player("Player 2"),
  ];

  final gameEngine = GameEngine(players, random);
  gameEngine.playTurn();
}
