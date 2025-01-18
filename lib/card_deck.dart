import 'dart:math';

enum CardType {
  treasureIsland(
    "Treasure Island",
    "🏝️💰",
    "Set aside one or more dice and reroll others.",
  ),

  skull(
    "Skull",
    "💀",
    "Turn begins with additional skull.",
  ),

  watchman(
    "Watchman",
    "💂‍♂️🗡️",
    "Reroll one skull once per turn.",
  ),

  pirateShip(
    "Pirate Ship",
    "⛵🏴‍☠️",
    "Must roll minimum number of swords to score any points.",
  ),

  coin(
    "Coin",
    "🪙",
    "Turn begins with additional coin.",
  ),

  diamond(
    "Diamond",
    "💎",
    "Turn begins with additional diamond.",
  ),

  animals(
    "Animals",
    "🐒🦜",
    "Monkey and parrots count as one type.",
  );

  const CardType(this.name, this.symbol, this.effect);

  final String name;
  final String symbol;
  final String effect;

  @override
  String toString() => symbol;
}

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
