import 'dart:math';

import '../models/models.dart';

/// Represents a game die with six sides: 💎, 🪙, 🐒, 🦜, 🗡️, 💀
class Die {
  final Random _random;

  Die([Random? random]) : _random = random ?? Random() {
    roll();
  }

  /// Returns one of the six sides of the die.
  DieType roll() {
    face = DieType.values[_random.nextInt(DieType.values.length)];
    return face;
  }

  /// Current face of the die
  late DieType face;
}
