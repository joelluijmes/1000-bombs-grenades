import 'package:thousand_bombs_grenades/models/turn_state.dart';

import '../models/card_type.dart';
import '../models/die.dart';

/// Game logic regarding a specific turn e.g., calculate its value.
class Turn {
  static final bonusSymbols = {DieType.coin.symbol, DieType.diamond.symbol};
  static final animalsSymbols = {DieType.parrot.symbol, DieType.monkey.symbol};
  static const coinDiamondBonusValue = 100;
  static const skullThreshold = 3;
  static const deadValue = -1;
  static const fullSetBonusValue = 500;
  static const totalDiceCount = 8;

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
    if (isDead()) {
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

    return bonusCount * coinDiamondBonusValue;
  }

  /// Calculates the value of regular combination symbols
  int _calculateCombinationValue() {
    final dieTypeCounts = <DieType, int>{};
    var animalCount = 0;

    for (var side in state.rolledDice) {
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

    final noSkulls = _countSkulls() == 0;
    if (noSkulls && contributingDiceCount + animalCount == totalDiceCount) {
      value += fullSetBonusValue;
    }

    return value;
  }

  /// Calculates whether the skull threshold has been met
  bool isDead() {
    var skullCount = _countSkulls();

    return skullCount >= skullThreshold;
  }

  int _countSkulls() {
    var skullCount = state.card == CardType.skull ? 1 : 0;
    skullCount +=
        state.rolledDice.where((side) => side == DieType.skull).length;

    return skullCount;
  }

  String prettyFormat() {
    final buffer = StringBuffer();
    const boxWidth = 68;

    // Top border and title section
    buffer.writeln('╔${"═" * (boxWidth - 2)}╗');
    buffer.writeln('║${" " * (boxWidth - 2)}║');
    buffer.writeln('║${" " * 20}THOUSAND BOMBS & GRENADES${" " * 21}║');
    buffer.writeln('║${" " * (boxWidth - 2)}║');
    buffer.writeln('╚${"═" * (boxWidth - 2)}╝');
    buffer.writeln();

    // Card section (no borders)
    buffer.writeln('${" " * 25}Current Card: ${state.card.symbol}');
    buffer.writeln('${" " * 25}${state.card.name}');
    buffer.writeln('${" " * 10}${state.card.effect}');
    buffer.writeln();

    buffer.writeln('=' * boxWidth);
    buffer.writeln();

    // Dice section header (no borders)
    buffer.writeln('${" " * 31}DICE');
    buffer.writeln();

    // Dice numbers - using fixed width spacing
    buffer.write(" " * 9);
    for (int i = 0; i < totalDiceCount; i++) {
      buffer.write('${(i + 1)}${" " * 6}');
    }
    buffer.writeln();

    // Dice values - using fixed width spacing for emojis
    buffer.write(" " * 8);
    for (int i = 0; i < totalDiceCount; i++) {
      if (i < state.rolledDice.length) {
        buffer.write(' ${state.rolledDice[i].symbol}     ');
      } else {
        buffer.write('       ');
      }
    }
    buffer.writeln();
    buffer.writeln();

    // Score section with border
    buffer.writeln('╔${"═" * (boxWidth - 2)}╗');
    final score = calculateValue();
    if (score == deadValue) {
      buffer.writeln('║${" " * 27}💀  DEAD  💀${" " * 28}║');
    } else {
      buffer.writeln('║${" " * 27}Score:  $score${" " * 28}║');
    }
    buffer.writeln('╚${"═" * (boxWidth - 2)}╝');

    return buffer.toString();
  }
}
