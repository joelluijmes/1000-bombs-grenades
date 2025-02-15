import 'dart:io';

import 'package:thousand_bombs_grenades/controllers/controllers.dart';
import 'package:thousand_bombs_grenades/domain/domain.dart';
import 'package:thousand_bombs_grenades/models/models.dart';

/// Handles the console-based user interface for the game
class ConsoleUI {
  final GameEngine _gameEngine;

  /// Creates a new ConsoleUI instance with the given game engine
  ConsoleUI(this._gameEngine);

  /// Runs a single turn of the game
  /// Handles player input and displays the game state after each move
  void playTurn() {
    bool turnEnded = false;

    GameState state = _gameEngine.initializeGame([Player("Player 1")]);
    final score = TurnLogic.calculateValue(state.turnState);
    print(_prettyFormatTurn(state.turnState, score));

    while (!turnEnded) {
      final move = _getPlayerMove();
      print('Player move: $move');

      final moveResult = _gameEngine.handleMove(state, move);
      if (moveResult is InvalidMove) {
        print('Invalid move, reason: ${moveResult.reason}');
        continue;
      }

      if (move is EndMove) {
        turnEnded = true;
        break;
      }

      final score = TurnLogic.calculateValue(state.turnState);
      print(_prettyFormatTurn(state.turnState, score));
    }
  }

  BaseMove _getPlayerMove() {
    while (true) {
      print("Enter move: ");
      print(" q - end move");
      print(" <n> - dices to rethrow (split by space)");

      final input = stdin.readLineSync();
      if (input == "q") {
        return EndMove();
      }

      final parts = input?.split(" ") ?? [];
      if (parts.isEmpty) {
        print("Invalid input");
        continue;
      }

      final indices = parts.map((part) => int.parse(part)).toList();
      return ThrowDiceMove(indices);
    }
  }

  String _prettyFormatTurn(TurnState state, int score) {
    final buffer = StringBuffer();
    const boxWidth = 68;

    // Top border and title section
    buffer.writeln('╔${"═" * (boxWidth - 2)}╗');
    buffer.writeln('║${" " * (boxWidth - 2)}║');
    buffer.writeln('║${" " * 20}THOUSAND BOMBS & GRENADES${" " * 21}║');
    buffer.writeln('║${" " * (boxWidth - 2)}║');
    buffer.writeln('╚${"═" * (boxWidth - 2)}╝');
    buffer.writeln();

    // Card section (no borders)
    buffer.writeln('${" " * 25}Current Card: ${state.card.symbol}');
    buffer.writeln('${" " * 25}${state.card.name}');
    buffer.writeln('${" " * 10}${state.card.effect}');
    buffer.writeln();

    buffer.writeln('=' * boxWidth);
    buffer.writeln();

    // Dice section header (no borders)
    buffer.writeln('${" " * 31}DICE');
    buffer.writeln();

    // Dice numbers - using fixed width spacing
    buffer.write(" " * 9);
    for (int i = 0; i < totalDiceCount; i++) {
      buffer.write('${(i + 1)}${" " * 6}');
    }
    buffer.writeln();

    // Dice values - using fixed width spacing for emojis
    buffer.write(" " * 8);
    for (int i = 0; i < totalDiceCount; i++) {
      if (i < state.dice.length) {
        buffer.write(' ${state.dice[i].symbol}     ');
      } else {
        buffer.write('       ');
      }
    }
    buffer.writeln();
    buffer.writeln();

    // Score section with border
    buffer.writeln('╔${"═" * (boxWidth - 2)}╗');
    if (score == deadValue) {
      buffer.writeln('║${" " * 27}💀  DEAD  💀${" " * 28}║');
    } else {
      buffer.writeln('║${" " * 27}Score:  $score${" " * 28}║');
    }
    buffer.writeln('╚${"═" * (boxWidth - 2)}╝');

    return buffer.toString();
  }
}
