import 'dart:math';

import 'package:thousand_bombs_grenades/card_deck.dart';
import 'package:thousand_bombs_grenades/die.dart';
import 'package:thousand_bombs_grenades/game_engine.dart';

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
    final turn = TurnState(deck, dice);

    final sides = turn.rolledDice;
    final card = turn.card;
    final value = turn.calculateValue();

    print("Value of Card=$card, Dice=$sides, Value=$value");
  }
}
