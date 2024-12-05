import 'package:dartx/dartx.dart';

const sampleSolution = '143';

void solveDay05(String input) {
  // https://adventofcode.com/2024/day/5
  // Solve Part 1 here

  final split = input.split('\n\n');
  final rulesRaw = split[0];
  final updatesRaw = split[1];

  final rules = rulesRaw.split('\n').map((line) {
    final matches = RegExp(r'(\d+)\|(\d+)').allMatches(line);
    final x = matches.first.group(1)!;
    final z = matches.first.group(2)!;
    return (int.parse(x), int.parse(z));
  }).toList();

  final Map<int, List<int>> upwardsRules = {};
  final Map<int, List<int>> downwardRules = {};
  for (final rule in rules) {
    final (x, z) = rule;
    upwardsRules.putIfAbsent(x, () => []).add(z);
    downwardRules.putIfAbsent(z, () => []).add(x);
  }
  final updates = updatesRaw.split('\n').map((line) {
    final parts = line.split(',');
    return parts.map(int.parse).toList();
  }).toList();

  int result = 0;
  for (int i = 0; i < updates.length; i++) {
    final update = updates[i];
    bool violation = false;
    for (int j = 0; j < update.length; j++) {
      final page = update[j];
      final before = update.sublist(0, j);
      final after = update.sublist(j + 1);

      final smaller = upwardsRules[page] ?? [];
      final allKnownSmaller = smaller.containsAll(after);
      final bigger = downwardRules[page] ?? [];
      final allKnownBigger = bigger.containsAll(before);

      if (!allKnownSmaller || !allKnownBigger) {
        violation = true;
        print('Violation at ${i + 1}th update ${update} page ${page}');
        break;
      }
    }
    if (!violation) {
      final middle = update[update.length ~/ 2];
      print('No violation at ${i + 1}th update ${update}, middle page $middle');
      result += middle;
    }
  }

  print(result);
}
