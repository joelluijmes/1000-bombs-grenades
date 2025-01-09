import 'package:thousand_bombs_grenades/card_deck.dart';
import 'package:thousand_bombs_grenades/die.dart';
import 'package:thousand_bombs_grenades/game_engine.dart';

const seed = 42;

void main(List<String> arguments) {
  print("Throwing 10 times to illustrate our die works:");
  final die = Die(seed);
  for (var i = 0; i < 10; i++) {
    print(die.roll());
  }

  print("Drawing 10 cards to illustrate our card deck works:");
  final deck = CardDeck(seed);
  for (var i = 0; i < 10; i++) {
    print(deck.draw());
  }

  print("Trying to calculate some values");
  final gameEngine = GameEngine();

  for (var i = 1; i < 8; i++) {
    final dice = List.filled(i, "💎");
    final card = "💎";

    print(
        "Value of Card=$card, Dice=$dice: ${gameEngine.calculateValue(card, dice)}");
  }

  final dice = ["🐒", "🐒", "🐒", "🐒", "🦜", "🦜", "🦜", "🦜"];
  final card = "💎";

  print(
      "Value of Card=$card, Dice=$dice: ${gameEngine.calculateValue(card, dice)}");
}
