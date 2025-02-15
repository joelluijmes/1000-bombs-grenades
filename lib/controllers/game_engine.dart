import 'dart:math';

import 'package:thousand_bombs_grenades/models/models.dart';
import 'package:thousand_bombs_grenades/domain/domain.dart';

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

  /// Handles a single move
  ///
  /// Returns true when EndMove is given.
  bool handleMove(BaseMove move) {
    if (move is EndMove) {
      return true;
    }

    if (move is ThrowDiceMove) {
      // TODO: check valid die
      for (final index in move.indices) {
        dice[index].roll();
      }

      List<DieType> sides = dice.map((die) => die.face).toList();
      state.turnState = TurnState(state.turnState.card, sides);
    }

    return false;
  }
}
