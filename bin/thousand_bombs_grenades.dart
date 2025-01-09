import 'package:thousand_bombs_grenades/card_deck.dart';
import 'package:thousand_bombs_grenades/die.dart';

const seed = 42;

void main(List<String> arguments) {
  print("Throwing 10 times to illustrate our die works:");
  var dice = Die(seed);
  for (var i = 0; i < 10; i++) {
    print(dice.roll());
  }

  print("Drawing 10 cards to illustrate our card deck works:");
  var deck = CardDeck(seed);
  for (var i = 0; i < 10; i++) {
    print(deck.draw());
  }
}
