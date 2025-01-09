import 'package:thousand_bombs_grenades/die.dart';

const seed = 42;

void main(List<String> arguments) {
  var dice = Die(seed);

  print("Throwing 10 times to illustrate our die works:");
  for (var i = 0; i < 10; i++) {
    print(dice.roll());
  }
}
