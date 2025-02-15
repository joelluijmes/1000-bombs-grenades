import 'package:test/test.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

void main() {
  group('Die', () {
    test('roll() should return a valid DieType', () {
      final result = DieType.roll();
      expect(DieType.values.contains(result), true);
    });
  });
}
