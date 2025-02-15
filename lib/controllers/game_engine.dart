import 'dart:math';

import 'package:thousand_bombs_grenades/models/models.dart';
import 'package:thousand_bombs_grenades/domain/domain.dart';

class GameEngine {
  final Random _random;

  final CardDeck _deck;

  GameEngine([Random? random])
      : _random = random ?? Random(),
        _deck = CardDeck(random);

  GameState initializeGame(List<Player> players) {
    final card = _deck.draw();
    final turnState = TurnState.init(card);

    return GameState.init(players, turnState);
  }

  /// Handles a single move
  ///
  /// Returns true when EndMove is given.
  GameState handleMove(GameState currentState, BaseMove move) {
    if (move is EndMove) {
      return currentState;
    }

    if (move is ThrowDiceMove) {
      final faces = currentState.turnState.dice.isNotEmpty
          ? List<DieType>.of(currentState.turnState.dice)
          : List.filled(totalDiceCount, DieType.coin);

      // TODO: check valid die
      for (final index in move.indices) {
        faces[index] = DieType.roll(_random);
      }

      final turnState = currentState.turnState.copyWith(dice: faces);
      return currentState.copyWith(turnState: turnState);
    }

    throw Exception("Invalid move $move");
  }
}
