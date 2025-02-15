import 'models.dart';

/// Represents the state of current turn, after rolling dice.
class TurnState {
  final CardType card;

  final List<DieType> dice;

  TurnState(this.card, this.dice);

  factory TurnState.init(CardType card) {
    return TurnState(card, []);
  }

  TurnState copyWith({CardType? card, List<DieType>? dice}) {
    return TurnState(
      card ?? this.card,
      dice ?? this.dice,
    );
  }
}
