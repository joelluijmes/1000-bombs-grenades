import 'card_deck.dart';
import 'die.dart';

class TurnState {
  static final bonusSymbols = {DieSides.coin.symbol, DieSides.diamond.symbol};
  static const bonusValue = 100;
  static const skullThreshold = 3;

  /// Lookup table which yields the points based on the amount of occurrences.
  static const countValueTable = {
    3: 100,
    4: 200,
    5: 500,
    6: 1000,
    7: 2000,
    8: 4000,
  };

  final Dice heldDice;

  final Dice rolledDice;

  final CardType card;

  TurnState(CardDeck deck, List<Die> dice)
      : card = deck.draw(),
        heldDice = [],
        rolledDice = dice.map((die) => die.roll()).toList();

  int calculateValue() {
    if (_calculateIsDead()) {
      return -1;
    }

    final bonusValue = _calculateBonusValue();
    final combinationValue = _calculateCombinationValue();

    return bonusValue + combinationValue;
  }

  /// Calculates the value of bonus symbols
  int _calculateBonusValue() {
    var bonusCount = bonusSymbols.contains(card.symbol) ? 1 : 0;
    bonusCount +=
        rolledDice.where((side) => bonusSymbols.contains(side.symbol)).length;

    return bonusCount * bonusValue;
  }

  /// Calculates the value of regular combination symbols
  int _calculateCombinationValue() {
    final dieTypeCounts = <DieSides, int>{};

    for (var side in rolledDice) {
      if (side != DieSides.skull) {
        dieTypeCounts[side] = (dieTypeCounts[side] ?? 0) + 1;
      }
    }

    // Determine combinations value per type
    final dieTypeValues = dieTypeCounts.map(
        (dieSide, count) => MapEntry(dieSide, countValueTable[count] ?? 0));

    // And aggregate to single value
    var value =
        dieTypeValues.values.reduce((value, element) => value + element);

    return value;
  }

  /// Calculates whether the skull threshold has been met
  bool _calculateIsDead() {
    var skullCount = card == CardType.skull ? 1 : 0;
    skullCount += rolledDice.where((side) => side == DieSides.skull).length;

    return skullCount >= skullThreshold;
  }
}
