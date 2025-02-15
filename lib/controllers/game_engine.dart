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
  BaseMoveResult handleMove(GameState currentState, BaseMove move) {
    if (move is EndMove) {
      return ValidMove(currentState);
    }

    if (move is ThrowDiceMove) {
      final faces = currentState.turnState.dice.isNotEmpty
          ? List<DieType>.of(currentState.turnState.dice)
          : List.filled(totalDiceCount, DieType.coin);

      for (final index in move.indices) {
        if (index < 1 || index > totalDiceCount) {
          return InvalidMove(currentState, InvalidMoves.outOfBounds);
        }

        if (faces[index] == DieType.skull) {
          return InvalidMove(currentState, InvalidMoves.rolledASkull);
        }

        faces[index] = DieType.roll(_random);
      }

      final turnState = currentState.turnState.copyWith(dice: faces);
      return ValidMove(currentState.copyWith(turnState: turnState));
    }

    throw Exception("Invalid move $move");
  }
}
