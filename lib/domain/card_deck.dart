import 'dart:math';

import 'package:thousand_bombs_grenades/models/models.dart';

/// Represents a card deck with following options:
/// - Treasure Island: 🏝️💰
/// - Skull: 💀
/// - Watchman: 💂‍♂️🗡️
/// - Pirate Ship: ⛵🏴‍☠️
/// - Gold Coin: 🪙
/// - Diamond: 💎
/// - Animals: 🐒🦜
class CardDeck {
  final List<CardType> cards = [];

  final Random _random;

  CardDeck([Random? random]) : _random = random ?? Random() {
    _reshuffleDeck();
  }

  /// Draws a card from the deck.
  CardType draw() {
    if (cards.isEmpty) {
      _reshuffleDeck();
    }

    return cards.removeAt(0);
  }

  /// Initializes the card deck with 10 cards for each type.
  void _reshuffleDeck() {
    cards.clear();

    // TODO: count how many cards actually exist for each type
    for (var i = 0; i < 10; i++) {
      cards.addAll(CardType.values);
    }

    cards.shuffle(_random);
  }
}
