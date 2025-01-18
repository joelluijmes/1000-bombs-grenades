import 'dart:math';

typedef Dice = List<DieSides>;

enum DieSides {
  diamond("💎"),
  coin("🪙"),
  monkey("🐒"),
  parrot("🦜"),
  sword("🗡️"),
  skull("💀");

  const DieSides(this.symbol);

  static DieSides bySymbol(String symbol) {
    return DieSides.values.firstWhere((side) => side.symbol == symbol);
  }

  final String symbol;

  @override
  String toString() => symbol;
}

/// Represents a game die with six sides: 💎, 🪙, 🐒, 🦜, 🗡️, 💀
class Die {
  final Random _random;

  Die([Random? random]) : _random = random ?? Random();

  /// Returns one of the six sides of the die.
  DieSides roll() => DieSides.values[_random.nextInt(DieSides.values.length)];
}
