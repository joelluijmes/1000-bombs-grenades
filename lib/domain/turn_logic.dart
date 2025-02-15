import 'package:thousand_bombs_grenades/models/models.dart';
import 'domain.dart';

/// Game logic regarding a specific turn e.g., calculate its value.
class TurnLogic {
  static int calculateValue(TurnState state) {
    if (isDead(state)) {
      return deadValue;
    }

    final bonusValue = _calculateBonusValue(state);
    final combinationValue = _calculateCombinationValue(state);

    return bonusValue + combinationValue;
  }

  /// Calculates whether the skull threshold has been met
  static bool isDead(TurnState state) {
    var skullCount = _countSkulls(state);

    return skullCount >= skullThreshold;
  }

  /// Calculates the value of bonus symbols
  static int _calculateBonusValue(TurnState state) {
    var bonusCount = bonusSymbols.contains(state.card.symbol) ? 1 : 0;
    bonusCount +=
        state.dice.where((side) => bonusSymbols.contains(side.symbol)).length;

    return bonusCount * coinDiamondBonusValue;
  }

  /// Calculates the value of regular combination symbols
  static int _calculateCombinationValue(TurnState state) {
    final dieTypeCounts = <DieType, int>{};
    var animalCount = 0;

    for (var side in state.dice) {
      if (side == DieType.skull) {
        continue;
      }

      // When the animal card is drawn, we count monkeys and parrots together
      if (state.card == CardType.animals &&
          animalsSymbols.contains(side.symbol)) {
        animalCount++;
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

    // And add the animal count (when applicable)
    value += countValueTable[animalCount] ?? 0;

    // We are eligible for bonus when all dice contribute value
    final contributingDiceCount = dieTypeCounts.entries.fold(
        0,
        (cur, entry) =>
            cur + ((dieTypeValues[entry.key] ?? 0) > 0 ? entry.value : 0));

    final noSkulls = _countSkulls(state) == 0;
    if (noSkulls && contributingDiceCount + animalCount == totalDiceCount) {
      value += fullSetBonusValue;
    }

    return value;
  }

  static int _countSkulls(TurnState state) {
    var skullCount = state.card == CardType.skull ? 1 : 0;
    skullCount += state.dice.where((side) => side == DieType.skull).length;

    return skullCount;
  }
}
