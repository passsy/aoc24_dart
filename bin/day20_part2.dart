// https://adventofcode.com/2024/day/20
import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

void solveDay20(String input, {int larger = 100}) {
  final grid = AocGrid<Node>(
    data: input,
    mapPoint: (it, point) {
      return switch (it) {
        '#' => Wall(),
        '.' => Path(),
        'S' => Path()..start = true,
        'E' => Path()..end = true,
        _ => throw ArgumentError('Unknown character $it')
      };
    },
    pointToString: (it, point) {
      if (it is Path && it.start) return 'S';
      if (it is Path && it.end) return 'E';
      if (it is Path && it.highlighted) return 'O';
      if (it is Path) return '.';
      if (it is Wall) return '#';
      throw ArgumentError('Unknown node $it');
    },
  );

  final start = grid
      .getAllGridPoints()
      .firstWhere((it) => it.value! is Path && (it.value! as Path).start);
  final end = grid
      .getAllGridPoints()
      .firstWhere((it) => it.value! is Path && (it.value! as Path).end);

  final fastestPath = grid.findFastestPath(start.point, end.point,
      isPath: (it) => it.value! is Path);

  final Map<int, List<GridPoint<Node>>> savings = {};
  for (int i = 0; i < fastestPath!.length; i++) {
    for (int j = 0; j < fastestPath.length; j++) {
      if (i == j) {
        continue;
      }
      final from = fastestPath[i];
      final to = fastestPath[j];

      final pFrom = from.point;
      final pTo = to.point;
      final distance = pFrom.manhattanDistance(pTo);

      if (distance > 20) {
        continue;
      }
      final segmentLength = (i - j).abs();
      final saved = segmentLength - distance;
      if (saved >= larger) {
        savings.putIfAbsent(saved, () => []);
        savings[saved]!.add(from);
      }
    }
  }

  final mapValues = savings
      .mapValues((e) => e.value.length ~/ 2)
      .toList()
      .sortedBy((e) => e.first)
      .toList();

  print(mapValues
      .map((e) =>
          'There are ${e.second} cheats that save ${e.first} picoseconds')
      .join('\n'));
  print('All counted: ${mapValues.sumBy((e) => e.second)}');

  print(mapValues.sumBy((e) => e.second));
}

sealed class Node {}

class Path extends Node {
  bool start = false;
  bool end = false;
  bool highlighted = false;
}

class Wall extends Node {}
