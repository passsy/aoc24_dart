import 'package:dartx/dartx.dart';

const sampleSolution = '161';

void solveDay03(String input) {
  // https://adventofcode.com/2024/day/3
  // Solve Part 1 here

  final List<(int, int)> muls = input.split('\n').flatMap((line) {
    final matches = RegExp(r'mul\((\d+),(\d+)\)').allMatches(line);
    final List<(int, int)> list = [];
    for (final match in matches) {
      print(match.group(1));
      print(match.group(2));
      print('---');
      final a = int.parse(match.group(1)!);
      final b = int.parse(match.group(2)!);
      list.add((a, b));
    }
    return list;
  }).toList();

  int result = 0;
  for (int i = 0; i < muls.length; i++) {
    final (int, int) pair = muls[i];
    print(pair);
    result += pair.$1 * pair.$2;
  }

  print(result);
}
