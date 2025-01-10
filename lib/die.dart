import 'dart:math';

/// Represents a game die with six sides: 💎, 🪙, 🐒, 🦜, 🗡️, 💀
class Die {
  final sides = const [
    "💎",
    "🪙",
    "🐒",
    "🦜",
    "🗡️",
    "💀",
  ];

  final Random _random;

  Die([int? seed]) : _random = Random(seed);

  /// Returns one of the six sides of the die.
  String roll() => sides[_random.nextInt(sides.length)];
}
