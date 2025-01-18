import 'dart:math';

import 'package:thousand_bombs_grenades/game/game.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

void main(List<String> arguments) {
  final random = Random(42);

  print("Throwing 10 times to illustrate our die works:");
  final die = Die(random);
  for (var i = 0; i < 10; i++) {
    print(die.roll());
  }

  print("Drawing 10 cards to illustrate our card deck works:");
  final deck = CardDeck(random);
  for (var i = 0; i < 10; i++) {
    print(deck.draw());
  }

  print("Trying to calculate some values");

  final dice = List.filled(8, Die(random));

  for (var i = 0; i < 10; i++) {
    final card = deck.draw();
    final sides = dice.map((die) => die.roll()).toList();

    final turnState = TurnState(card, sides);
    final turn = Turn(turnState);

    final value = turn.calculateValue();

    print("Value of Card=$card, Dice=$sides, Value=$value");
  }
}
