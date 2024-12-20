// https://adventofcode.com/2024/day/20
import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

void solveDay20(String input) {
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

  final allWalls =
      grid.getAllGridPoints().where((it) => it.value! is Wall).toList();

  final Map<int, List<GridPoint<Node>>> savings = {};
  int result = 0;
  for (int w = 0; w < allWalls.length; w++) {
    final wall = allWalls[w];

    if (wall.point == start.point || wall.point == end.point) {
      continue;
    }
    if (wall.point.y == 0 || wall.point.y == grid.height - 1) {
      continue;
    }
    if (wall.point.x == 0 || wall.point.x == grid.width - 1) {
      continue;
    }

    final south = grid.getGridPoint(wall.south);
    final east = grid.getGridPoint(wall.east);
    final north = grid.getGridPoint(wall.north);
    final west = grid.getGridPoint(wall.west);
    final isCuttableNorthSouth = south.value is Path && north.value is Path;
    final isCuttableEastWest = east.value is Path && west.value is Path;
    final isCuttable = isCuttableNorthSouth || isCuttableEastWest;
    if (!isCuttable) {
      continue;
    }

    final int cutSave;
    if (isCuttableNorthSouth) {
      final from = fastestPath!.indexOf(north);
      final to = fastestPath.indexOf(south);
      if (from > to) {
        cutSave = from - to - 2;
      } else {
        cutSave = to - from - 2;
      }
    } else {
      final from = fastestPath!.indexOf(east);
      final to = fastestPath.indexOf(west);
      if (from > to) {
        cutSave = from - to - 2;
      } else {
        cutSave = to - from - 2;
      }
    }
    if (cutSave < fastestPath.length) {
      final diff = cutSave;
      savings.putIfAbsent(diff, () => []);
      savings[diff]!.add(wall);
      if (diff >= 100) {
        result += 1;
      }
    }
  }
  final mapValues = savings
      .mapValues((e) => e.value.length)
      .toList()
      .sortedBy((e) => e.first)
      .toList();
  print(mapValues
      .map((e) =>
          'There are ${e.second} cheats that save ${e.first} picoseconds')
      .join('\n'));

  print('All counted: ${mapValues.sumBy((e) => e.second)}');
  print(result);
}

sealed class Node {}

class Path extends Node {
  bool start = false;
  bool end = false;
  bool highlighted = false;
}

class Wall extends Node {}
