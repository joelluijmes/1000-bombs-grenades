import 'package:test/test.dart';
import 'package:thousand_bombs_grenades/models/models.dart';
import 'package:thousand_bombs_grenades/game/card_deck.dart';
import 'dart:math';

void main() {
  group('CardDeck', () {
    late Random seededRandom;
    late CardDeck deck;

    setUp(() {
      seededRandom = Random(42);
      deck = CardDeck(seededRandom);
    });

    test('initial deck should not be empty', () {
      expect(deck.cards, isNotEmpty);
    });

    test('draw() should return a valid CardType', () {
      final card = deck.draw();
      expect(CardType.values.contains(card), isTrue);
    });

    test('draw() should remove card from deck', () {
      final initialLength = deck.cards.length;
      deck.draw();
      expect(deck.cards.length, equals(initialLength - 1));
    });

    test('deck should reshuffle when empty', () {
      // Draw all cards
      final initialLength = deck.cards.length;
      final drawnCards = <CardType>[];

      for (var i = 0; i < initialLength; i++) {
        drawnCards.add(deck.draw());
      }

      // Verify deck is empty
      expect(deck.cards, isEmpty);

      // Draw one more card - should trigger reshuffle
      final newCard = deck.draw();
      expect(deck.cards, isNotEmpty);
      expect(CardType.values.contains(newCard), isTrue);
    });

    test('drawing with same seed should produce same sequence', () {
      // First deck
      final deck1 = CardDeck(Random(42));
      final draws1 = List.generate(5, (_) => deck1.draw());

      // Second deck with same seed
      final deck2 = CardDeck(Random(42));
      final draws2 = List.generate(5, (_) => deck2.draw());

      // Sequences should be identical
      expect(draws1, equals(draws2));
    });
  });
}
