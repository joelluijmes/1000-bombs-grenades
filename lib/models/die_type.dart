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

  final String symbol;

  @override
  String toString() => symbol;
}
