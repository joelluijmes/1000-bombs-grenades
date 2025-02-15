import 'dart:math';

import 'package:thousand_bombs_grenades/controllers/controllers.dart';
import 'package:thousand_bombs_grenades/views/views.dart';

void main(List<String> arguments) {
  final random = Random(1);

  final gameEngine = GameEngine(random);
  final ui = ConsoleUI(gameEngine);

  ui.playTurn();
}
