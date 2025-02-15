import 'models.dart';

/// Represents the state of current turn, after rolling dice.
class TurnState {
  final CardType card;

  final List<DieType> dice;

  TurnState(this.card, this.dice);
}
