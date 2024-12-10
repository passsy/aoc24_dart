import 'dart:io';

import 'package:aoc24/grid.dart';

const sampleSolution = '41';

void solveDay06(String input) {
  // https://adventofcode.com/2024/day/6
  // Solve Part 1 here

  final grid = AocGrid<String>(
    data: input,
    mapPoint: (data, point) => data,
  );

  Point? moveUntilObstacle(Point point, Direction direction) {
    Point next = point;
    while (!grid.isOutOfBounds(next)) {
      final prev = next;
      grid.setValue(prev, 'X');
      next = direction(next);
      final nextChar = grid.getValueOrNull(next);
      if (nextChar == '#') {
        return prev;
      }
    }
    return null;
  }

  Point point = grid.findFirst((it) => it.value == '^').point;

  Direction direction = up;
  while (true) {
    grid.setValue(point, 'X');
    final next = moveUntilObstacle(point, direction);
    if (next == null) {
      // out of bounds
      break;
    }
    point = next;
    direction = direction.rotateRight();
    grid.printToConsole();
  }

  final result = grid.findAll((it) => it.value == 'X').length;
  print(result);
}

typedef Direction = Point Function(Point point);

Point up(Point point) => (x: point.x, y: point.y - 1);
Point down(Point point) => (x: point.x, y: point.y + 1);
Point left(Point point) => (x: point.x - 1, y: point.y);
Point right(Point point) => (x: point.x + 1, y: point.y);

extension on Direction {
  Direction rotateRight() {
    if (this == up) {
      return right;
    }
    if (this == right) {
      return down;
    }
    if (this == down) {
      return left;
    }
    if (this == left) {
      return up;
    }
    throw Exception('Unknown direction');
  }
}
