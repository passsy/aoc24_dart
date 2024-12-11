import 'package:dartx/dartx.dart';

void solveDay11(String input) {
  // https://adventofcode.com/2024/day/11
  // Solve Part 2 here

  final List<int> stones = input.split(' ').map(int.parse).toList().toList();
  print(blink(75, stones));
}

int blink(int n, List<int> input) {
  // save stone and count in map. Order does not matter
  Map<int, int> stones = {};
  for (final stone in input) {
    stones.putIfAbsent(stone, () => 0);
    final count = stones[stone]!;
    stones[stone] = count + 1;
  }

  for (int blink = 1; blink <= n; blink++) {
    final Map<int, int> newStones = {};
    for (final s in stones.entries) {
      final stone = s.key;
      final amount = s.value;
      final split = splitStone(stone);
      for (final s in split) {
        newStones.putIfAbsent(s, () => 0);
        final count = newStones[s]!;
        newStones[s] = count + amount;
      }
    }
    stones = newStones;
    final count = stones.mapEntries((e) => e.value).sum();
    print('After ${blink} blink, stones: ${count}');
  }
  final count = stones.mapEntries((e) => e.value).sum();
  return count;
}

// memoization
final known = <int, List<int>>{};

List<int> splitStone(int stone) {
  final isKnown = known[stone];
  if (isKnown != null) {
    return isKnown;
  }
  final List<int> output = [];
  if (stone == 0) {
    output.add(1);
  } else if (stone.toString().length % 2 == 0) {
    final half = stone.toString().length ~/ 2;
    final firstHalf = int.parse(stone.toString().substring(0, half));
    final secondHalf = int.parse(stone.toString().substring(half));
    output.add(firstHalf);
    output.add(secondHalf);
  } else {
    output.add(stone * 2024);
  }
  known[stone] = output;
  return output;
}
