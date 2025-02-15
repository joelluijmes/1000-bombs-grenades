import 'package:test/test.dart';
import 'package:thousand_bombs_grenades/domain/domain.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

void testTurn({
  required String description,
  required TurnState state,
  required int expectedValue,
}) {
  test(description, () {
    final value = TurnLogic.calculateValue(state);

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
          state: TurnState(
            card: CardType.diamond,
            dice: List.filled(3, DieType.skull),
          ),
          expectedValue: deadValue,
        );

        testTurn(
          description: 'returns -1 with two skulls rolled and skull card',
          state: TurnState(
            card: CardType.skull,
            dice: List.filled(2, DieType.skull),
          ),
          expectedValue: deadValue,
        );
      });

      group("calculate combination value", () {
        for (final entry in valueMap.entries) {
          final count = entry.key;
          final expectedValue = entry.value;

          testTurn(
            description: 'returns $expectedValue for $count monkeys',
            state: TurnState(
              card: CardType.skull,
              dice: List.filled(count, DieType.monkey),
            ),
            expectedValue: expectedValue,
          );
        }
      });

      group("calculate bonus value", () {
        for (final bonus in {DieType.diamond, DieType.coin}) {
          testTurn(
            description: 'returns 1000 for 5 $bonus',
            state: TurnState(
              card: CardType.treasureIsland,
              dice: List.filled(5, bonus),
            ),
            expectedValue: 1000,
          );
        }

        testTurn(
          description: 'adds bonus for diamond card',
          state: TurnState(
            card: CardType.diamond,
            dice: [DieType.diamond, DieType.diamond],
          ),
          expectedValue: 300,
        );

        testTurn(
          description: 'adds bonus for coin card',
          state: TurnState(
            card: CardType.coin,
            dice: [DieType.coin, DieType.coin],
          ),
          expectedValue: 300,
        );
      });

      group("calculate with animal card", () {
        testTurn(
          description: 'returns 600 for 4🦜 + 3🐒 without animal card',
          state: TurnState(
            card: CardType.treasureIsland,
            dice: [
              ...List.filled(4, DieType.parrot),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 300,
        );

        testTurn(
          description: 'returns 2000 for 4🦜 + 3🐒 with animal card',
          state: TurnState(
            card: CardType.animals,
            dice: [
              ...List.filled(4, DieType.parrot),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 2000,
        );
      });

      group("calculate bonus symbols + combination value", () {
        testTurn(
          description: 'returns 1100 for 5💎 + 3🐒',
          state: TurnState(
            card: CardType.skull,
            dice: [
              ...List.filled(5, DieType.diamond),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 1100,
        );

        testTurn(
          description: 'returns 600 for 3💎 + 3🐒 + diamond card',
          state: TurnState(
            card: CardType.diamond,
            dice: [
              ...List.filled(3, DieType.diamond),
              ...List.filled(3, DieType.monkey)
            ],
          ),
          expectedValue: 600,
        );
      });

      group("calculate bonus when everything yields value", () {
        testTurn(
          description: 'returns 400 for 4🦜 + 4🐒 (no bonus) with skull card',
          state: TurnState(
            card: CardType.skull,
            dice: [
              ...List.filled(4, DieType.parrot),
              ...List.filled(4, DieType.monkey)
            ],
          ),
          expectedValue: 400,
        );

        testTurn(
          description:
              'returns 900 (400 + 500) for 4🦜 + 4🐒 with treasure island (bonus)',
          state: TurnState(
            card: CardType.treasureIsland,
            dice: [
              ...List.filled(4, DieType.parrot),
              ...List.filled(4, DieType.monkey)
            ],
          ),
          expectedValue: 900,
        );

        testTurn(
          description:
              'returns 4500 (400 + 500) for 4🦜 + 4🐒 with animals card (bonus)',
          state: TurnState(
            card: CardType.animals,
            dice: [
              ...List.filled(4, DieType.parrot),
              ...List.filled(4, DieType.monkey)
            ],
          ),
          expectedValue: 4500,
        );
      });
    });
  });
}
