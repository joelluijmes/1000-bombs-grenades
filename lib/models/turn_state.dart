import 'models.dart';

/// Represents the state of current turn, after rolling dice.
class TurnState {
  final CardType card;

  final List<DieType> dice;

  TurnState({required this.card, required this.dice});

  TurnState copyWith({List<DieType>? dice}) {
    return TurnState(
      card: card,
      dice: dice ?? this.dice,
    );
  }
}
