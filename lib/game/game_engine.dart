import 'dart:math';

import 'package:thousand_bombs_grenades/game/game.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

class GameEngine {
  final GameState state;

  final CardDeck deck;

  final List<Die> dice;

  GameEngine(List<Player> players, [Random? random])
      : state = GameState(players),
        deck = CardDeck(random),
        dice = List.filled(8, Die(random));

  void startTurn() {
    print('[${state.currentPlayer.name}] Player turn begins!');

    final card = deck.draw();
    print('[${state.currentPlayer.name}] Draws $card - ${card.effect}');

    final sides = dice.map((die) => die.roll()).toList();
    print('[${state.currentPlayer.name}] Rolls $sides');

    final turnState = TurnState(card, sides);
    final turn = Turn(turnState);

    print(turn.prettyFormat());

    // final value = turn.calculateValue();
    // print('[${state.currentPlayer.name}] Turn value $value');

    // if (turn.isDead()) {
    //   print('[${state.currentPlayer.name}] Died. Switching player..');
    // }
  }
}
