import 'dart:math';

/// Enumeration of possible sides of the Die.
enum DieType {
  diamond("💎"),
  coin("🪙"),
  monkey("🐒"),
  parrot("🦜"),
  sword("🗡️"),
  skull("💀");

  const DieType(this.symbol);

  static DieType bySymbol(String symbol) {
    return DieType.values.firstWhere((side) => side.symbol == symbol);
  }

  static DieType roll([Random? random]) {
    return DieType.values[(random ?? Random()).nextInt(DieType.values.length)];
  }

  final String symbol;

  @override
  String toString() => symbol;
}
