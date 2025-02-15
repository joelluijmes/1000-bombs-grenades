import 'package:thousand_bombs_grenades/models/models.dart';

abstract class BaseMove {}

class ThrowDiceMove implements BaseMove {
  ThrowDiceMove(this.indices);

  final List<int> indices;

  @override
  String toString() {
    return "THROWS ${indices.join(', ')}";
  }
}

class EndMove implements BaseMove {
  @override
  String toString() {
    return "END";
  }
}

abstract class BaseMoveResult {
  final GameState state;

  BaseMoveResult(this.state);
}

class ValidMove extends BaseMoveResult {
  ValidMove(super.state);
}

class InvalidMove extends BaseMoveResult {
  final InvalidMoves reason;

  InvalidMove(super.state, this.reason);
}

enum InvalidMoves {
  outOfBounds,

  rolledASkull,
}
