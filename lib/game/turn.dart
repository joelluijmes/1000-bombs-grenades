import 'package:thousand_bombs_grenades/models/turn_state.dart';

import '../models/card_type.dart';
import '../models/die.dart';

/// Game logic regarding a specific turn e.g., calculate its value.
class Turn {
  static final bonusSymbols = {DieType.coin.symbol, DieType.diamond.symbol};
  static final animalsSymbols = {DieType.parrot.symbol, DieType.monkey.symbol};
  static const bonusValue = 100;
  static const skullThreshold = 3;
  static const deadValue = -1;

  /// Lookup table which yields the points based on the amount of occurrences.
  static const countValueTable = {
    3: 100,
    4: 200,
    5: 500,
    6: 1000,
    7: 2000,
    8: 4000,
  };

  final TurnState state;

  Turn(this.state);

  int calculateValue() {
    if (_calculateIsDead()) {
      return deadValue;
    }

    final bonusValue = _calculateBonusValue();
    final combinationValue = _calculateCombinationValue();

    return bonusValue + combinationValue;
  }

  /// Calculates the value of bonus symbols
  int _calculateBonusValue() {
    var bonusCount = bonusSymbols.contains(state.card.symbol) ? 1 : 0;
    bonusCount += state.rolledDice
        .where((side) => bonusSymbols.contains(side.symbol))
        .length;

    return bonusCount * bonusValue;
  }

  /// Calculates the value of regular combination symbols
  int _calculateCombinationValue() {
    final dieTypeCounts = <DieType, int>{};
    var animalCounts = 0;

    for (var side in state.rolledDice) {
      if (side == DieType.skull) {
        continue;
      }

      // When the animal card is drawn, we count monkeys and parrots together
      if (state.card == CardType.animals &&
          animalsSymbols.contains(side.symbol)) {
        animalCounts++;
      } else {
        dieTypeCounts[side] = (dieTypeCounts[side] ?? 0) + 1;
      }
    }

    // Determine combinations value per type
    final dieTypeValues = dieTypeCounts.map(
        (dieSide, count) => MapEntry(dieSide, countValueTable[count] ?? 0));

    // And aggregate to single value
    var value =
        dieTypeValues.values.fold(0, (value, element) => value + element);

    // And finally add the animal count (when applicable)
    value += countValueTable[animalCounts] ?? 0;

    return value;
  }

  /// Calculates whether the skull threshold has been met
  bool _calculateIsDead() {
    var skullCount = state.card == CardType.skull ? 1 : 0;
    skullCount +=
        state.rolledDice.where((side) => side == DieType.skull).length;

    return skullCount >= skullThreshold;
  }
}
