import 'package:test/test.dart';
import 'package:thousand_bombs_grenades/game/game.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

void testTurn({
  required String description,
  required TurnState state,
  required int expectedValue,
}) {
  test(description, () {
    final turn = Turn(state);
    final value = turn.calculateValue();

    expect(value, expectedValue);
  });
}

void main() {
  group('Turn', () {
    group("calculateValue", () {
      const valueMap = {
        3: 100,
        4: 200,
        5: 500,
        6: 1000,
        7: 2000,
        8: 4000,
      };

      group("calculate is dead", () {
        testTurn(
          description: 'returns -1 with three skulls rolled',
          state: TurnState(CardType.diamond, List.filled(3, DieType.skull)),
          expectedValue: Turn.deadValue,
        );

        testTurn(
          description: 'returns -1 with two skulls rolled and skull card',
          state: TurnState(CardType.skull, List.filled(2, DieType.skull)),
          expectedValue: Turn.deadValue,
        );
      });

      group("calculate combination value", () {
        for (final entry in valueMap.entries) {
          final count = entry.key;
          final expectedValue = entry.value;

          testTurn(
            description: 'returns $expectedValue for $count monkeys',
            state: TurnState(
                CardType.treasureIsland, List.filled(count, DieType.monkey)),
            expectedValue: expectedValue,
          );
        }
      });

      group("calculate bonus value", () {
        for (final bonus in {DieType.diamond, DieType.coin}) {
          testTurn(
            description: 'returns 1000 for 5 $bonus',
            state: TurnState(CardType.treasureIsland, List.filled(5, bonus)),
            expectedValue: 1000,
          );
        }

        testTurn(
          description: 'adds bonus for diamond card',
          state: TurnState(
            CardType.diamond,
            [DieType.diamond, DieType.diamond],
          ),
          expectedValue: 300,
        );

        testTurn(
          description: 'adds bonus for coin card',
          state: TurnState(
            CardType.coin,
            [DieType.coin, DieType.coin],
          ),
          expectedValue: 300,
        );
      });

      group("calculate with animal card", () {
        testTurn(
          description: 'returns 600 for 5🦜 + 3🐒 without animal card',
          state: TurnState(
            CardType.treasureIsland,
            [
              ...List.filled(5, DieType.parrot),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 600,
        );

        testTurn(
          description: 'returns 8000 for 5🦜 + 3🐒 with animal card',
          state: TurnState(
            CardType.animals,
            [
              ...List.filled(5, DieType.parrot),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 4000,
        );
      });

      group("calculate bonus + combination value", () {
        testTurn(
          description: 'returns 1100 for 5💎 + 3🐒',
          state: TurnState(
            CardType.treasureIsland,
            [
              ...List.filled(5, DieType.diamond),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 1100,
        );

        testTurn(
          description: 'returns 600 for 3💎 + 3🐒 + diamond card',
          state: TurnState(
            CardType.diamond,
            [
              ...List.filled(3, DieType.diamond),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 600,
        );
      });
    });
  });
}
