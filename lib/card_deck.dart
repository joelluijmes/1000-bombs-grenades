import 'dart:math';

/// Represents a card deck with following options:
/// - Treasure Island: 🏝️💰
/// - Skull: 💀
/// - Watchman: 💂‍♂️🗡️
/// - Pirate Ship: ⛵🏴‍☠️
/// - Gold Coin: 🪙
/// - Diamond: 💎
/// - Animals: 🐒🦜
class CardDeck {
  final cards = [];

  final Random _random;

  CardDeck([int? seed]) : _random = Random(seed) {
    _reshuffleDeck();
  }

  /// Draws a card from the deck.
  String draw() {
    if (cards.isEmpty) {
      _reshuffleDeck();
    }

    return cards.removeAt(0);
  }

  /// Initializes the card deck with 10 cards for each type.
  void _reshuffleDeck() {
    // TODO: count how many cards actually exist for each type
    for (var i = 0; i < 10; i++) {
      cards.add("🏝️💰");
      cards.add("💀");
      cards.add("💂‍♂️🗡️");
      cards.add("⛵🏴‍☠️");
      cards.add("🪙");
      cards.add("💎");
      cards.add("🐒🦜");
    }

    cards.shuffle(_random);
  }
}
