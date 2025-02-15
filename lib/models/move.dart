import 'package:thousand_bombs_grenades/models/models.dart';

/// Base class for all possible moves in the game
abstract class BaseMove {}

/// Represents a move to throw specific dice again
class ThrowDiceMove implements BaseMove {
  /// Creates a new throw dice move with the given indices to reroll
  ThrowDiceMove(this.indices);

  /// The indices of the dice to reroll (1-based)
  final List<int> indices;

  @override
  String toString() {
    return "THROWS ${indices.join(', ')}";
  }
}

/// Represents a move to end the current turn
class EndMove implements BaseMove {
  @override
  String toString() {
    return "END";
  }
}

/// Base class for all possible results of a move
abstract class BaseMoveResult {
  /// The game state after the move
  final GameState state;

  /// Creates a new move result with the given game state
  BaseMoveResult(this.state);
}

/// Represents a successful move that resulted in a valid game state
class ValidMove extends BaseMoveResult {
  ValidMove(super.state);
}

/// Represents a failed move that resulted in an invalid game state
class InvalidMove extends BaseMoveResult {
  /// The reason why the move was invalid
  final InvalidMoves reason;

  InvalidMove(super.state, this.reason);
}

/// Possible reasons why a move might be invalid
enum InvalidMoves {
  /// The dice index was out of the valid range
  outOfBounds,

  /// Attempted to reroll a skull die
  rolledASkull,
}
