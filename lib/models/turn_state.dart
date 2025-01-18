import 'models.dart';

/// Represents the state of current turn, after rolling dice.
class TurnState {
  final CardType card;

  final Dice rolledDice;

  TurnState(this.card, this.rolledDice);
}
