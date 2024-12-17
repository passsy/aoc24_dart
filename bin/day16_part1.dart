// https://adventofcode.com/2024/day/16
import 'package:aoc24/grid.dart';

void solveDay16(String input) {
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
  );

  final pathTiles = grid
      .getAllGridPoints()
      .where((it) => it.value is Path)
      .map((it) => it as GridPoint<Path>);
  final start = pathTiles.firstWhere((it) => it.value!.start);
  final end = pathTiles.firstWhere((it) => it.value!.end);

  // assume corners are nodes, straight lines are edges
  // count the lowest number of nodes to reach the end

  // walk from start to end
  // djikstra's algorithm

  start.value!.cheapestPath = 0;
  start.value!.direction = oneEast;
  final Set<GridPoint<Path>> openSet = pathTiles.toSet();
  while (openSet.isNotEmpty) {
    final GridPoint<Path> current = openSet.reduce(
        (a, b) => (a.value!.cheapestPath < b.value!.cheapestPath) ? a : b);

    openSet.remove(current);
    final direction = current.value!.direction!;
    final nextPointInDirection = direction(current.point);
    final next = grid.getGridPointWithOOB(nextPointInDirection);
    if (next.value is Path) {
      final tentativeScore = current.value!.cheapestPath + 1;
      if (tentativeScore < next.value!.cheapestPath) {
        next.value!.cheapestPath = tentativeScore;
        next.value!.direction = direction;
      }
    }
    final left = direction.rotateLeft();
    final nextLeft = grid.getGridPoint(left(current.point));
    if (nextLeft.value is Path) {
      final tentativeScore = current.value!.cheapestPath + 1001;
      if (tentativeScore < nextLeft.value!.cheapestPath) {
        nextLeft.value!.cheapestPath = tentativeScore;
        nextLeft.value!.direction = left;
      }
    }
    final right = direction.rotateRight();
    final nextRight = grid.getGridPoint(right(current.point));
    if (nextRight.value is Path) {
      final tentativeScore = current.value!.cheapestPath + 1001;
      if (tentativeScore < nextRight.value!.cheapestPath) {
        nextRight.value!.cheapestPath = tentativeScore;
        nextRight.value!.direction = right;
      }
    }
  }

  print(end.value!.cheapestPath);
}

sealed class Node {
  int cheapestPath = 1_000_000_000;
  MoveDirection? direction;

  @override
  String toString() {
    return '$cheapestPath';
  }
}

class Path extends Node {
  bool start = false;
  bool end = false;
}

class Wall extends Node {}
