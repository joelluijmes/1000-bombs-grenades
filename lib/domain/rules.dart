import 'package:thousand_bombs_grenades/models/models.dart';

const coinDiamondBonusValue = 100;
const skullThreshold = 3;
const deadValue = -1;
const fullSetBonusValue = 500;
const totalDiceCount = 8;
final bonusSymbols = {DieType.coin.symbol, DieType.diamond.symbol};
final animalsSymbols = {DieType.parrot.symbol, DieType.monkey.symbol};

/// Lookup table which yields the points based on the amount of occurrences.
const countValueTable = {
  3: 100,
  4: 200,
  5: 500,
  6: 1000,
  7: 2000,
  8: 4000,
};
