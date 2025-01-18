import 'card_deck.dart';
import 'die.dart';

class GameEngine {
  /// Lookup table which yields the points based on the amount of occurrences.
  static const countValueTable = {
    3: 100,
    4: 200,
    5: 500,
    6: 1000,
    7: 2000,
    8: 4000,
  };

  /// Calculates the value of the current turn.
  int calculateValue(CardType card, Dice dice) {
    // Lets start with counting the amounts of each type
    final dieTypeCounts = <DieSides, int>{};

    // The "bonus" type 💎 and 🪙 get an additional count
    var bonusCount = 0;
    if (card.symbol == "💎" || card.symbol == "🪙") {
      dieTypeCounts[DieSides.bySymbol(card.symbol)] = 1;
      bonusCount++;
    }

    // Three skulls means end of turn -> 0 points 💀
    // A card can also be a 💀
    var skullCount = 0;
    if (card.symbol == "💀") {
      skullCount++;
    }

    for (final die in dice) {
      dieTypeCounts[die] = (dieTypeCounts[die] ?? 0) + 1;

      if (die.symbol == "💎" || die.symbol == "🪙") {
        bonusCount++;
      }

      if (die.symbol == "💀") {
        skullCount++;
      }
    }

    if (skullCount >= 3) {
      return -1;
    }
    // TODO: Go to skull island
    // else if (skullCount > 3) {
    // }

    // Then calculate the value for each type
    final dieTypeValues = dieTypeCounts.map(
        (dieSide, count) => MapEntry(dieSide, countValueTable[count] ?? 0));

    // And aggregate to single value
    var value =
        dieTypeValues.values.reduce((value, element) => value + element);

    // Each bonus type is worth 100 points, so we add that
    value += bonusCount * 100;

    return value;
  }
}
