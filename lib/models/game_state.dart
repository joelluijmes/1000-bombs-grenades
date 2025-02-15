import 'package:thousand_bombs_grenades/domain/domain.dart';

import 'models.dart';

class GameState {
  final List<Player> players;

  final CardDeck deck;

  final Player currentPlayer;

  final TurnState turnState;

  GameState({
    required this.players,
    required this.currentPlayer,
    required this.deck,
    required this.turnState,
  });

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
