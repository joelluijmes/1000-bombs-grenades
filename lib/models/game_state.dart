import 'models.dart';

class GameState {
  final List<Player> players;

  final Player currentPlayer;

  final TurnState turnState;

  GameState({
    required this.players,
    required this.currentPlayer,
    required this.turnState,
  });

  factory GameState.init(List<Player> players, TurnState turnState) {
    return GameState(
      players: players,
      currentPlayer: players.first,
      turnState: turnState,
    );
  }

  GameState copyWith({
    List<Player>? players,
    Player? currentPlayer,
    TurnState? turnState,
  }) {
    return GameState(
      players: players ?? this.players,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      turnState: turnState ?? this.turnState,
    );
  }
}
