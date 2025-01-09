typedef DieSide = String;
typedef Card = String;
typedef Dice = List<DieSide>;

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
  int calculateValue(Card card, Dice dice) {
    // Lets start with counting the amounts of each type
    final dieTypeCounts = <DieSide, int>{};

    // The "bonus" type 💎 and 🪙 get an additional count
    var bonusCount = 0;
    if (card == "💎" || card == "🪙") {
      dieTypeCounts[card] = 1;
      bonusCount++;
    }

    for (final die in dice) {
      dieTypeCounts[die] = (dieTypeCounts[die] ?? 0) + 1;

      if (die == "💎" || die == "🪙") {
        bonusCount++;
      }
    }

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
