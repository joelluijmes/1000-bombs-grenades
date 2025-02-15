import 'dart:io';
import 'dart:math';

import 'package:thousand_bombs_grenades/game/game.dart';
import 'package:thousand_bombs_grenades/models/models.dart';
import 'package:thousand_bombs_grenades/models/move.dart';

class GameEngine {
  final CardDeck deck;

  final List<Die> dice;

  late GameState state;

  GameEngine(List<Player> players, [Random? random])
      : deck = CardDeck(random),
        dice = List.filled(8, Die(random)) {
    // Setup game
    final card = deck.draw();
    final turnState = TurnState(card, []);

    state = GameState(players, turnState);
  }

  void playTurn() {
    bool turnEnded = false;

    while (!turnEnded) {
      final move = _getPlayerMove();
      print('[${state.currentPlayer.name}] Player move: $move');

      if (move is EndMove) {
        turnEnded = true;
        break;
      }

      if (move is ThrowDiceMove) {
        // TODO: check valid die
        for (final index in move.indices) {
          dice[index].roll();
        }

        List<DieType> sides = dice.map((die) => die.face).toList();
        state.turnState = TurnState(state.turnState.card, sides);
      }

      final turn = Turn(state.turnState);
      print(turn.prettyFormat());
    }
  }

  BaseMove _getPlayerMove() {
    while (true) {
      print("Enter move: ");
      print(" q - end move");
      print(" <n> - dices to rethrow (split by space)");

      final input = stdin.readLineSync();
      if (input == "q") {
        return EndMove();
      }

      final parts = input?.split(" ") ?? [];
      if (parts.isEmpty) {
        print("Invalid input");
        continue;
      }

      final indices = parts.map((part) => int.parse(part)).toList();
      return ThrowDiceMove(indices);
    }
  }
}
