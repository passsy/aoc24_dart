import 'package:dartx/dartx.dart';

const sampleSolution = '11';

void solveDay01(String input) {
  // https://adventofcode.com/2024/day/1
  // Solve Part 1 here

  final lines = input.split('\n');
  final words = lines.map((line) {
    final matches = RegExp(r'(\d+)   (\d+)').allMatches(line);
    return (a: matches.first.group(1)!, b: matches.first.group(2)!);
  }).toList();

  final firstDigits = words.map((it) => it.a).sorted();
  final secondDigits = words.map((it) => it.b).sorted();

  int result = 0;
  for (int index = 0; index < firstDigits.length; index++) {
    final a = int.parse(firstDigits[index]);
    final b = int.parse(secondDigits[index]);
    final diff = (a - b).abs();
    print('$a - $b => $diff');
    result += diff;
  }

  print(result);
}
