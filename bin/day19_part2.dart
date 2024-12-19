// https://adventofcode.com/2024/day/19
import 'package:dartx/dartx.dart';

void solveDay19(String input) {
  final parts = input.split('\n\n');
  final List<String> patterns = parts[0].split(', ').toList();
  final designs = parts[1].split('\n').toList();

  int result = 0;
  for (int i = 0; i < designs.length; i++) {
    final line = designs[i];
    result += possibleDesignsCount(line, {}, patterns);
    print('i: $i, line: $line');
  }

  print(result);
}

int possibleDesignsCount(
  String design,
  Map<String, int> memo,
  List<String> patterns,
) {
  if (memo.containsKey(design)) {
    return memo[design]!;
  }
  final sum = patterns.filter((it) => design.startsWith(it)).map((it) {
    final remaining = design.substring(it.length);
    if (remaining.isEmpty) return 1;
    return possibleDesignsCount(remaining, memo, patterns);
  }).sum();
  memo[design] = sum;
  return sum;
}
