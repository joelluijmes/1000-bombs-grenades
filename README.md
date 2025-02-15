# 1000 Bombs & Grenades!

A digital adaptation of the physical board game "1000 Bommen & Granaten" created by Haim Shafir and published by 999 Games. This project serves as both a learning exercise for the Dart programming language and (hopefully) a platform for implementing and testing various AI algorithms, particularly Q-learning and other reinforcement learning approaches.

> [!WARNING]
> I just started out building this game. I just put it on GitHub as means of version control. It is in no way finished or even playable at this point.

## Game Overview

For detailed information about game rules, components, and mechanics, see:

- [Official game manual](https://www.999games.nl/1000-bommen-granaten.html)
- [English game overview](docs/game_overview.md)

## Requirements

- Dart SDK: Personally ran with version 3.7.0 and likely with most Dart 3.x versions
- No additional dependencies required for running the game

## Installation

1. Ensure you have Dart SDK installed (version 3.7.0 or compatible)
2. Clone this repository
3. Run `dart pub get` to install dependencies

## Running the Game

```bash
dart run bin/thousand_bombs_grenades.dart
```

## Project Structure

The project follows a MVC-like pattern

```
lib/
├── domain/         # Model: Core game rules and logic
├── models/         # Model: Data models
└── views/          # View: User interface
├── controllers/    # Controller: Game logic controllers
```

## Development Status

This project is currently under active development. Features are being added incrementally with a focus on:

1. Core game mechanics implementation
2. Console-based user interface
3. AI agent integration (planned)
4. Flutter UI (planned)
