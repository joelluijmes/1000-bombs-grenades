import 'package:thousand_bombs_grenades/models/models.dart';

class GameState {
  final List<Player> players;

  Player currentPlayer;

  GameState(this.players) : currentPlayer = players[0];
}
