const sampleSolution = '2';

void solveDay02(String input) {
  // https://adventofcode.com/2024/day/2
  // Solve Part 1 here

  final lines = input.split('\n');
  final reports = lines.map((line) {
    return line.split(' ').map(int.parse).toList();
  }).toList();

  int result = 0;
  for (int index = 0; index < reports.length; index++) {
    final levels = reports[index];
    if (isSafe(levels)) {
      result += 1;
      print('SAFE Always increasing: $levels');
    } else {
      print('Not always increasing: $levels');
    }
  }

  print(result);
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
