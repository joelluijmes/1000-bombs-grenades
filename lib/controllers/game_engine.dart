import 'dart:math';

import 'package:thousand_bombs_grenades/models/models.dart';
import 'package:thousand_bombs_grenades/domain/domain.dart';

/// Manages the game logic and state transitions
class GameEngine {
  final Random _random;

  /// Creates a new GameEngine instance with an optional random number generator
  GameEngine([Random? random]) : _random = random ?? Random();

  /// Initializes a new game with the given players
  /// Returns the initial game state
  GameState initializeGame(List<Player> players) {
    final deck = CardDeck(_random);
    final card = deck.draw();
    final dice = List.generate(totalDiceCount, (_) => DieType.roll(_random));
    final turnState = TurnState(card: card, dice: dice);

    return GameState(
        players: players,
        currentPlayer: players.first,
        deck: deck,
        turnState: turnState);
  }

  /// Processes a player's move and returns the result
  ///
  /// Returns a [ValidMove] if the move was successful, or an [InvalidMove] if the move was illegal
  BaseMoveResult handleMove(GameState currentState, BaseMove move) {
    if (move is EndMove) {
      final nextPlayer = currentState.players[
          (currentState.players.indexOf(currentState.currentPlayer) + 1) %
              currentState.players.length];

      currentState.copyWith(currentPlayer: nextPlayer);
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
      final updatedState = currentState.copyWith(turnState: turnState);
      return ValidMove(updatedState);
    }

    throw Exception("Invalid move $move");
  }
}
