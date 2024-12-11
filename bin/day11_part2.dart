import 'package:dartx/dartx.dart';

extension type Stone(int number) {}

// https://adventofcode.com/2024/day/11
void solveDay11(String input) {
  final Map<Stone, int> stones = input
      .split(' ')
      .groupBy((n) => Stone(int.parse(n)))
      .mapValues((it) => it.value.length);

  print(blink(75, stones));
}

int blink(int n, Map<Stone, int> stones) {
  if (n == 0) {
    return stones.stoneCount;
  }

  final newStones = <Stone, int>{};
  for (final MapEntry(key: stone, value: amount) in stones.entries) {
    for (final split in splitStone(stone)) {
      newStones[split] = (newStones[split] ?? 0) + amount;
    }
  }

  print('After ${75 - n + 1} blink, stones: ${newStones.stoneCount}');
  return blink(n - 1, newStones);
}

List<Stone> splitStone(Stone stone) {
  if (stone.number == 0) {
    return [Stone(1)];
  }
  final stoneString = stone.number.toString();
  if (stoneString.length % 2 == 0) {
    final half = stoneString.length ~/ 2;
    final firstHalf = int.parse(stoneString.substring(0, half));
    final secondHalf = int.parse(stoneString.substring(half));
    return [Stone(firstHalf), Stone(secondHalf)];
  }
  return [Stone(stone.number * 2024)];
}

extension on Map<Stone, int> {
  int get stoneCount => mapEntries((e) => e.value).sum();
}
