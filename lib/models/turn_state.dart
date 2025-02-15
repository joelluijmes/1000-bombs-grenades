import 'models.dart';

/// Represents the state of current turn, after rolling dice.
class TurnState {
  /// The current card in play for this turn
  final CardType card;

  /// The current state of all dice in play
  final List<DieType> dice;

  /// Creates a new turn state with the given card and dice
  TurnState({required this.card, required this.dice});

  /// Creates a copy of this turn state with optionally modified dice
  TurnState copyWith({List<DieType>? dice}) {
    return TurnState(
      card: card,
      dice: dice ?? this.dice,
    );
  }
}
