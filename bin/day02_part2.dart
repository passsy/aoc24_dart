import 'package:dartx/dartx.dart';

const sampleSolution = '4';

void solveDay02(String input) {
  // https://adventofcode.com/2024/day/2
  // Solve Part 2 here
  final lines = input.split('\n');
  final reports = lines.map((line) {
    return line.split(' ').map(int.parse).toList();
  }).toList();

  int result = 0;
  for (int i = 0; i < reports.length; i++) {
    final levels = reports[i];

    if (isSafeWithError(levels)) {
      result += 1;
      print('SAFE: $levels\n');
    } else {
      print('Not safe: $levels\n');
    }
  }

  print(result);
}

bool isSafeWithError(List<int> levels) {
  if (isSafe(levels)) {
    print('SAFE: $levels\n');
    return true;
  }

  List<int> l = levels.toList();
  for (int removeIndex = 0; removeIndex <= l.length; removeIndex++) {
    l = levels.toList()..removeAt(removeIndex);
    if (isSafe(l)) {
      print('SAFE: $levels\n');
      return true;
    }
  }

  print('NOT SAFE: $levels\n');
  return false;
}

bool isSafe(List<int> levels) {
  print('Analyzing $levels');
  final bool Function(int diff) validation = levels[0] < levels[1]
      ? (diff) => diff < 0 && diff >= -3
      : (diff) => diff > 0 && diff <= 3;

  int start = levels[0];
  for (final level in levels.skip(1)) {
    final diff = start - level;
    if (validation(diff)) {
      start = level;
    } else {
      print('Failed at $level');
      return false;
    }
  }
  return true;
}
