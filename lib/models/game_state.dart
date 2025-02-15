import 'models.dart';

class GameState {
  final List<Player> players;

  Player currentPlayer;

  TurnState turnState;

  // final dice = List.filled(8, Die(random));

  GameState(this.players, this.turnState) : currentPlayer = players[0];
}
