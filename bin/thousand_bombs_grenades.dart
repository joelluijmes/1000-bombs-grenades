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
  final gameEngine = GameEngine();

  for (var i = 1; i < 8; i++) {
    final dice = List.filled(i, DieSides.diamond);
    final card = CardType.diamond;

    print(
        "Value of Card=$card, Dice=$dice: ${gameEngine.calculateValue(card, dice)}");
  }

  var dice = [
    ...List.filled(4, DieSides.monkey),
    ...List.filled(4, DieSides.parrot)
  ];
  var card = CardType.diamond;

  print(
      "Value of Card=$card, Dice=$dice: ${gameEngine.calculateValue(card, dice)}");

  dice = [
    ...List.filled(3, DieSides.skull),
    ...List.filled(5, DieSides.parrot)
  ];
  card = CardType.diamond;

  print(
      "Value of Card=$card, Dice=$dice: ${gameEngine.calculateValue(card, dice)}");
}
