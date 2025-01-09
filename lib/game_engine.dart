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

    // The cards 💎 and 🪙 get an additional count
    if (card == "💎" || card == "🪙") {
      dieTypeCounts[card] = 1;
    }

    for (final die in dice) {
      dieTypeCounts[die] = (dieTypeCounts[die] ?? 0) + 1;
    }

    // Then calculate the value for each type
    final dieTypeValues = dieTypeCounts.map(
        (dieSide, count) => MapEntry(dieSide, countValueTable[count] ?? 0));

    // And aggregate to single value
    final value =
        dieTypeValues.values.reduce((value, element) => value + element);

    return value;
  }
}
