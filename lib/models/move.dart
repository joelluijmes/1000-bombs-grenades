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
