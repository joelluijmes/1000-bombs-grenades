/// Enumeration of possible Cards.
enum CardType {
  treasureIsland(
    "Treasure Island",
    "🏝️",
    "Set aside one or more dice and reroll others.",
  ),

  skull(
    "Skull",
    "💀",
    "Turn begins with additional skull.",
  ),

  watchman(
    "Watchman",
    "💂‍♂️",
    "Reroll one skull once per turn.",
  ),

  pirateShip(
    "Pirate Ship",
    "⛵",
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
    "🐒",
    "Monkey and parrots count as one type.",
  );

  const CardType(this.name, this.symbol, this.effect);

  final String name;
  final String symbol;
  final String effect;

  @override
  String toString() => symbol;
}
