import 'package:thousand_bombs_grenades/domain/domain.dart';

import 'models.dart';

/// Represents the current state of the game
class GameState {
  /// List of all players in the game
  final List<Player> players;

  /// The deck of cards used in the game
  final CardDeck deck;

  /// The player whose turn it currently is
  final Player currentPlayer;

  /// The state of the current turn
  final TurnState turnState;

  GameState({
    required this.players,
    required this.currentPlayer,
    required this.deck,
    required this.turnState,
  });

  /// Creates a copy of this GameState with optionally modified properties
  GameState copyWith({
    Player? currentPlayer,
    TurnState? turnState,
  }) {
    return GameState(
      players: players,
      deck: deck,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      turnState: turnState ?? this.turnState,
    );
  }
}
