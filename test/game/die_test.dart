import 'package:test/test.dart';
import 'package:thousand_bombs_grenades/models/models.dart';
import 'package:thousand_bombs_grenades/domain/die.dart';
import 'dart:math';

void main() {
  group('Die', () {
    test('roll() should return a valid DieType', () {
      final die = Die();
      final result = die.roll();
      expect(DieType.values.contains(result), true);
    });

    test('roll() should be deterministic with seeded Random', () {
      // Create a seeded Random for deterministic testing
      final seededRandom = Random(42);
      final die = Die(seededRandom);

      // Roll multiple times and store results
      final results = List.generate(10, (_) => die.roll());

      // Create another die with same seed
      final die2 = Die(Random(42));
      final results2 = List.generate(10, (_) => die2.roll());

      // Both sequences should be identical
      expect(results, equals(results2));
    });
  });
}
